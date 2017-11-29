class Campaign < ActiveRecord::Base

  include CampaignMethods
  include CampaignValidator
  include Calculator

  belongs_to :webmaster
  
  has_many :products
  has_many :customers
  has_many :impressions,  :through => :products
  has_many :reactions,    :through => :products

  has_many :scenarios, :dependent => :destroy
  accepts_nested_attributes_for :scenarios
  
  before_create :set_relative_id

  default_scope { where('is_default = ? AND deleted = ?', false, false) }
  
  scope :running, -> { 
    enabled.where(
      "start_date IS NULL AND end_date IS NULL OR " <<
      "start_date <= ? AND end_date IS NULL OR " <<
      "start_date IS NULL AND end_date > ? OR " <<
      "start_date <= ? AND end_date > ?",
      Date.today,Date.today,Date.today,Date.today
    ) 
  }

  scope :enabled, -> { where(enabled:true) }

  def running?
    return false unless enabled?
    return true if start_date.nil? && end_date.nil?
    return true if start_date <= Date.today && end_date.nil?
    return true if start_date.nil? && end_date > Date.today
    return true if start_date <= Date.today && end_date > Date.today
    return false
  end
  
  def status
    return 'Running' if running?
    'Not running'
  end

  private

  def set_relative_id
    raise "Campaign must have a webmaster" unless webmaster
    self.relative_id = webmaster.campaigns.length + 1
  end

end
