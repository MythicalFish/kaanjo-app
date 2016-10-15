class Customer < ActiveRecord::Base

  self.primary_key = 'sid'

  include SharedMethods

  belongs_to :webmaster
  has_many :impressions
  has_many :reactions

  before_create :assign_sid
  before_create :throttle_creation

  def reacted_to? product
    reactions.find_by_product_id(product.id) ? true : false
  end

  def reaction_to product
    reactions.find_by_product_id(product.id)
  end

  private

  def throttle_creation

    time = Time.now
    index_limit = 200

    if webmaster.throttle_timer_1.nil? || time > webmaster.throttle_timer_1
      throttle_reset
    elsif time < webmaster.throttle_timer_1 && index_limit > webmaster.throttle_index_1
      throttle_increment
    else
      head 509
    end

  end

  def throttle_reset
    self.webmaster.update_attributes!(
      throttle_timer_1: Time.now + 60,
      throttle_index_1: 1
    )
  end

  def throttle_increment
    self.webmaster.throttle_index_1 += 1
    self.webmaster.save
  end

end
