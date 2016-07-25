class Product < ActiveRecord::Base

  has_many :impressions
  has_many :reactions
  belongs_to :webmaster
  before_create :generate_sid 

  scope :by_date, -> { order('created_at DESC') }

  def self.with_counts(opts = {from:nil, to:nil, order: :impression_count, direction:'DESC'})
    
    query = "products.*" <<
      ",COUNT(impressions.id) AS impression_count" <<
      ",COUNT(reactions.id) AS reaction_total" <<
      ",(COUNT(distinct reactions.id) / COUNT(distinct impressions.id)) * 100 AS total_ctr"

    ReactionType.all.each do |type|
      query << ",COUNT(distinct case when reactions.reaction_type_id = #{type.id} then reactions.id end) AS type_count_#{type.id}"
    end
    
    select(query).
      joins(:reactions).
      joins(:impressions).
      group("products.id").
      where(
        "reactions.created_at" => opts[:from]..opts[:to],
        "impressions.created_at" => opts[:from]..opts[:to]
      ).order("#{opts[:order]} #{opts[:direction]}")

  end

  scope :with_impression_counts, -> do
    select("products.*, COUNT(impressions.id) AS impression_count").
      joins("LEFT OUTER JOIN impressions ON (impressions.product_id = products.id)").
      group("products.id")
  end

  scope :with_reaction_counts_for, -> (type) do
    select("products.*, COUNT(reactions.id) AS type_count_#{type.id}").
      joins("LEFT OUTER JOIN reactions ON (reactions.product_id = products.id && reactions.reaction_type_id = #{type.id})").
      group("products.id")
  end

  scope :with_reaction_totals, -> do
    select("products.*, COUNT(reactions.id) AS reaction_total").
      joins("LEFT OUTER JOIN reactions ON (reactions.product_id = products.id)").
      group("products.id")
  end

  def breakdown
    
  end

  def impression_count
    impressions.length
  end

  def reaction_count(type=nil)
    type_id = type.id if type
    type_id = ReactionType.ids unless type_id
    reactions.where(reaction_type_id:type_id).length
  end

  def reaction_totals
    r = {}
    ReactionType.all.each do |type|
      r[type.name] = reaction_total(type)
    end
    r
  end

  def reaction_total type = nil
    # TODO: cache results
    if type
      reactions.where(reaction_type:type).length
    else
      reactions.length
    end
  end

  private

  def generate_sid
    begin
      secure_id = SecureRandom.hex(12)
    end while Product.where(:sid => secure_id).exists?
    self.sid = secure_id
  end

end
