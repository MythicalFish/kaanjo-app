class Campaign < ActiveRecord::Base

  include SharedMethods
  include Calculator
  include CampaignValidator

  belongs_to :webmaster
  
  has_many :products
  has_many :customers
  has_many :impressions,  :through => :products
  has_many :reactions,    :through => :products

  has_many :scenarios, :dependent => :destroy
  accepts_nested_attributes_for :scenarios
  
  before_create :set_relative_id

  default_scope { where('is_default = ? AND deleted = ?', false, false) }

  private

  def set_relative_id
    self.relative_id = webmaster.campaigns.length + 1
  end

end
