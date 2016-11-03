class DefaultCampaign < ActiveRecord::Base

  include CampaignValidator

  self.table_name = 'campaigns'
  has_many :scenarios, foreign_key: 'campaign_id'

  default_scope { where('is_default = ?', true) }
  before_create :set_as_default
  before_create :set_relative_id

  def self.find id
    where(is_default: true, relative_id: id).first
  end

  private

  def set_as_default
    self.is_default = true
  end

  def set_relative_id
    id = DefaultCampaign.last.try(:id) || 0
    self.relative_id = id + 1
  end


end