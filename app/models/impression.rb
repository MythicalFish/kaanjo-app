class Impression < ActiveRecord::Base

  belongs_to :webmaster
  belongs_to :product
  belongs_to :customer

  validates :webmaster_id, presence: true
  validates :product_id, presence: true
  validates :customer_id, presence: true

  before_create :build_associations

  def self.total from, to
    if from && to
      self.where(created_at:from..to).length
    else
      self.length
    end
  end

  private

  def build_associations
    if self.product
      self.webmaster = self.product.webmaster
    else
      raise "No product association found"
    end
  end

end
