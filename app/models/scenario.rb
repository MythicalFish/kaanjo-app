class Scenario < ActiveRecord::Base

  belongs_to :campaign
  belongs_to :emoticon
  has_many :reactions
  has_many :impressions

  def label
    read_attribute(:label) || emoticon.try(:label)
  end

  def self.default_set
    all.limit(6)
  end

  def image_url
    emoticon.image.url
  end
  
end
