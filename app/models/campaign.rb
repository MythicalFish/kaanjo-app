class Campaign < ActiveRecord::Base

  include SharedMethods
  include Calculator
  include CampaignValidator

  belongs_to :webmaster
  has_many :products
  has_many :impressions
  has_many :reactions
  has_and_belongs_to_many :reaction_types

  before_create :set_relative_id

  default_scope { where('is_default = ? AND deleted = ?', false, false) }

  validate :number_of_reaction_types

  def self.new_from_default id = 1
    attributes = DefaultCampaign.find(id).dup.attributes
    attributes[:relative_id] = nil
    attributes[:webmaster_id] = nil
    attributes[:is_default] = false
    attributes[:enabled] = false
    Campaign.new(attributes)
  end

  private

  def set_relative_id
    id = webmaster.campaigns.last.try(:relative_id) || 0
    self.relative_id = id + 1
  end

  def number_of_reaction_types
    errors.add(:reaction_types, "Max 6 reactions") if reaction_types.size > 6
    errors.add(:reaction_types, "Min 2 reactions") if reaction_types.size < 2
  end

end
