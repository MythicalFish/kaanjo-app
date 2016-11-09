class Scenario < ActiveRecord::Base

  belongs_to :campaign
  has_many :reactions
  belongs_to :emoticon


  def label
    read_attribute(:label) || emoticon.try(:label)
  end

  def self.default_set
    all.limit(6)
  end

  def image_url
    emoticon.image.url if emoticon
  end
  
end
