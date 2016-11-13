class Reaction < ActiveRecord::Base

  belongs_to :scenario
  belongs_to :impression

  alias_method :type, :scenario

  delegate :product, to: :impression
  delegate :customer, to: :impression

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

end
