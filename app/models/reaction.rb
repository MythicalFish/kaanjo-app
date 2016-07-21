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

  private

  def attach_to_webmaster
    if self.product
      self.webmaster = self.product.webmaster
    else
      raise "No product association found"
    end
  end

end
