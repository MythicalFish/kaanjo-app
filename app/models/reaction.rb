class Reaction < ActiveRecord::Base

  belongs_to :webmaster
  belongs_to :product
  belongs_to :reaction_type
  belongs_to :customer

  validates :webmaster_id, presence: true
  validates :product_id, presence: true
  validates :reaction_type_id, presence: true
  validates :customer_id, presence: true

  before_create :attach_to_webmaster

  alias_method :type, :reaction_type

  def self.total from, to
    if from && to
      self.where(created_at:from..to).length
    else
      self.length
    end
  end

  def self.counts from, to
    ReactionType.
      select( "reaction_types.*, 
              COUNT(reactions.id) AS count" ).
      joins(  :reactions ).
      where(  "reactions.created_at" => from..to ).
      group(  "reaction_types.id" )
  end

  private

  def attach_to_webmaster
    if self.product
      self.webmaster = self.product.webmaster
    else
      raise "No product association found"
    end
  end

end
