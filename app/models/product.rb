class Product < ActiveRecord::Base

  has_many :impressions
  has_many :reactions
  belongs_to :webmaster


end
