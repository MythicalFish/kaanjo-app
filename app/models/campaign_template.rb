class CampaignTemplate < ActiveRecord::Base

  include CampaignValidator

  self.table_name = 'campaigns'
  has_many :scenarios, foreign_key: 'campaign_id'
  accepts_nested_attributes_for :scenarios

  default_scope { where('is_default = ? AND deleted = ?', true, false) }
  before_create :set_as_default

  def to_campaign
    c = self.dup
    c.relative_id = nil
    c.is_default = false
    cc = Campaign.new(c.attributes.to_hash)
    self.scenarios.each do |s|
      cc.scenarios << s.dup
    end
    cc
  end

  private

  def set_as_default
    self.is_default = true
    self.relative_id = 0
  end

end