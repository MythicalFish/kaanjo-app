class Product < ActiveRecord::Base

  include SharedMethods
  include Calculator

  belongs_to :campaign
  has_many :scenarios, :through => :campaign
  has_many :impressions
  has_many :reactions
  has_many :customers, :through => :impressions

  before_create :assign_sid 

  scope :by_date, -> { order('created_at DESC') }

  def self.top_by_type from,to
    select(   "products.*,
              COUNT(distinct reactions.id) AS count,
              scenarios.label AS type_label").
      joins(  "LEFT JOIN reactions ON reactions.product_id = products.id" ).
      joins(  "LEFT JOIN scenarios ON reactions.scenario_id = scenarios.id" ).
      where(  "reactions.created_at" => from..to, ).
      order(  "count DESC" ).
      group(  "products.id").
      limit(  10 )
  end 

  def device_stats opts = {}

    opts = { 
      from: Time.now.beginning_of_day, 
      to: Time.now.end_of_day,
      order_by: 'impression_total',
      direction: 'DESC' 
      }.merge(opts)

    query = "impressions.*" << 
      ",COUNT(distinct impressions.id) AS impression_total" <<
      ",COUNT(distinct reactions.id) AS reaction_total"

    Scenario.all.each do |type|
      query << ",COUNT(distinct case when reactions.scenario_id = #{type.id} then reactions.id end) AS type_total_#{type.id}"
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
      group("impressions.device_type").
      order("#{opts[:order_by]} #{opts[:direction]}")

  end

end
