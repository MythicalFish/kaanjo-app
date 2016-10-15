class ReactionType < ActiveRecord::Base

  belongs_to :emoticon
  has_many :reactions

end
