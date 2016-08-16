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

  def devices
    Impression.
      where( :product_id => id ).
      group( :device_type ).
      count
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

  def device_stats from, to

    select(   "products.*, 
              COUNT(impressions.id) AS impressions_count,
              COUNT(reactions.id) AS reactions_total," ).
      joins(  :reactions ).
      joins(  "LEFT JOIN reaction_types ON reactions.reaction_type_id = reaction_types.id" ).
      where(  "products.id" => id,
              "reactions.created_at" => from..to ).
      group(  "reactions.reaction_type_id" ).
      order(  "count DESC").
      first

  end

end
