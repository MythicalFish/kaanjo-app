class Emoticon < ActiveRecord::Base

  include SharedMethods

  before_create :assign_sid

  has_many :scenarios

  has_attached_file :image,
    url: "/emoticons/:sid.:extension",
    path: ':rails_root/public/emoticons/:sid.:extension'

  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ }

  def self.category_names
    [
      'Miscellaneous',
      'Smileys',
      'Emotions',
      'Numbers',
      'Flags'
    ]
  end

  def self.categories
    r = {}
    category_names.each do |c|
      next if c == 'Miscellaneous'
      r[c] = Emoticon.where(category:c)
    end
    r['Miscellaneous'] = Emoticon.where(category:[nil,'Miscellaneous'])
    r
  end

  private

end