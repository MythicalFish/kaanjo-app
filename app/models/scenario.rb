class Scenario < ActiveRecord::Base

  include SharedMethods

  before_create :assign_sid

  belongs_to :campaign
  has_many :reactions
  belongs_to :emoticon

  has_attached_file :custom_emoticon,
    url: "/custom_emoticons/:sid.:extension",
    path: ':rails_root/public/custom_emoticons/:sid.:extension'

  validates_attachment :custom_emoticon, content_type: { content_type: /\Aimage\/.*\Z/ }

  scope :enabled, -> { where(enabled:true) }

  def label
    read_attribute(:label) || emoticon.try(:label)
  end

  def self.default_set
    all.limit(6)
  end

  def image_url
    if custom_emoticon.present?
      custom_emoticon.url
    elsif emoticon
      emoticon.image.url 
    end
  end
  
end
