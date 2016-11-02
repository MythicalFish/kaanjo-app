class Emoticon < ActiveRecord::Base

  include SharedMethods

  before_create :assign_sid

  has_many :reaction_types

  has_attached_file :image,
    url: "/emoticons/:sid.:extension",
    path: ':rails_root/public/emoticons/:sid.:extension'

  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ }

  private

end