class CampaignTemplate < ActiveRecord::Base

  include CampaignValidator

  self.table_name = 'campaigns'
  has_many :scenarios, foreign_key: 'campaign_id'

  default_scope { where('is_default = ? AND deleted = ?', true, false) }
  before_create :set_as_default
  before_create :set_relative_id

  private

  def set_as_default
    self.is_default = true
  end

  def set_relative_id
    id = CampaignTemplate.last.try(:id) || 0
    self.relative_id = id + 1
  end


end