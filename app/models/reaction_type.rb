class ReactionType < ActiveRecord::Base

  belongs_to :emoticon
  has_many :reactions

  def image_url
    emoticon.image.url
  end
  
end
