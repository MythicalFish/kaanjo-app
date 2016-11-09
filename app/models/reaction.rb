class Reaction < ActiveRecord::Base

  belongs_to :scenario
  belongs_to :impression

  before_create :build_associations

  alias_method :type, :scenario

  def self.total from, to
    if from && to
      self.where(created_at:from..to).length
    else
      self.length
    end
  end

  def self.counts from, to
    select( "scenarios.*, 
            COUNT(reactions.id) AS count" ).
    joins(  :scenario ).
    where(  "reactions.created_at" => from..to ).
    group(  "scenarios.id" )
  end

  private

  def build_associations
    raise "An Impression must be associated for Reaction creation" unless impression
    product_id = impression.product_id
    customer_id = impression.customer_id
  end

end
