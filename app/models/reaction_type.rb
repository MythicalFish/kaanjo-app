class ReactionType < ActiveRecord::Base

  has_one :emoticon
  has_many :reactions

end
