class Product < ActiveRecord::Base

  include SharedQueries
  include SharedMethods

  has_many :impressions
  has_many :reactions
  has_many :customers, through: :impressions
  belongs_to :webmaster
  before_create :assign_sid 

  scope :by_date, -> { order('created_at DESC') }

  def self.top_by_type from,to
    select(   "products.*,
              COUNT(distinct reactions.id) AS count,
              reaction_types.name AS type_name").
      joins(  "LEFT JOIN reactions ON reactions.product_id = products.id" ).
      joins(  "LEFT JOIN reaction_types ON reactions.reaction_type_id = reaction_types.id" ).
      where(  "reactions.created_at" => from..to, ).
      order(  "count DESC" ).
      group(  "products.id").
      limit(  10 )
  end 

  def get_reaction_total type = nil
    if type
      self.reactions.where(reaction_type:type).length
    else
      self.reactions.length
    end
  end

  def get_reaction_totals
    r = {}
    ReactionType.all.each do |type|
      r[type.name] = self.get_reaction_total(type)
    end
    r
  end

  def device_stats opts = { from: Time.now.beginning_of_day, to: Time.now.end_of_day }

    query = "impressions.*" << 
      ",COUNT(distinct impressions.id) AS impression_count" <<
      ",COUNT(distinct reactions.id) AS reaction_total"

    ReactionType.all.each do |type|
      query << ",COUNT(distinct case when reactions.reaction_type_id = #{type.id} then reactions.id end) AS type_count_#{type.id}"
    end

    Impression.select(query).
      joins("
        LEFT JOIN (
          SELECT * FROM 
            reactions
          WHERE 
            reactions.created_at BETWEEN '#{opts[:from]}' AND '#{opts[:to]}'
        ) AS reactions
        ON 
          reactions.product_id = #{id} AND
          reactions.device_type = impressions.device_type
      ").
      where(
        "impressions.product_id" => id,
        "impressions.created_at" => opts[:from]..opts[:to]
      ).
      group(  "impressions.device_type" )

  end

end
