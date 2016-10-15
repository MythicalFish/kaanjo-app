class Campaign < ActiveRecord::Base

  belongs_to :webmaster
  has_many :products
  has_and_belongs_to_many :reaction_types
  has_many :impressions
  has_many :reactions

  before_create :set_relative_id

  private

  def set_relative_id
    return if webmaster_id == 0
    id = webmaster.campaigns.last.try(:id) || 0
    self.relative_id = id + 1
  end

end
