class Reaction < ActiveRecord::Base

  belongs_to :product
  belongs_to :customer
  belongs_to :scenario

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


end
