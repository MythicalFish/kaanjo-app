class Impression < ActiveRecord::Base

  belongs_to :webmaster
  belongs_to :product
  belongs_to :customer

  validates :webmaster_id, presence: true
  validates :product_id, presence: true
  validates :customer_id, presence: true

  before_create :attach_to_webmaster

  def self.count_between from, to
    if from && to
      self.where(created_at:from..to).length
    else
      self.length
    end
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
