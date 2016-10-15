class Campaign < ActiveRecord::Base

  belongs_to :webmaster
  has_many :products
  has_many :impressions
  has_many :reactions
  has_and_belongs_to_many :reaction_types

  before_create :set_relative_id

  default_scope { where('is_default = ?', false) }

  def find id
    find_by_relative_id id
  end

  private

  def set_relative_id
    id = webmaster.campaigns.last.try(:id) || 0
    self.relative_id = id + 1
  end

end
