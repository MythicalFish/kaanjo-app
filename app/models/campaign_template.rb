class CampaignTemplate < ActiveRecord::Base

  include CampaignValidator

  self.table_name = 'campaigns'
  has_many :scenarios, foreign_key: 'campaign_id'
  accepts_nested_attributes_for :scenarios

  default_scope { where('is_default = ? AND deleted = ?', true, false) }
  before_create :set_as_default

  private

  def set_as_default
    self.is_default = true
    self.relative_id = 0
  end

end