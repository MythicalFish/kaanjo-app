class Emoticon < ActiveRecord::Base

  include SharedMethods

  before_create :assign_sid

  has_many :scenarios

  has_attached_file :image,
    url: "/emoticons/:sid.:extension",
    path: ':rails_root/public/emoticons/:sid.:extension'

  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ }

  def self.library
    where(is_default:true)
  end

  private

end