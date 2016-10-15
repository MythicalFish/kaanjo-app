class Campaign < ActiveRecord::Base

  self.primary_key = 'sid'

  belongs_to :webmaster
  has_many :products
  has_many :reaction_types
  has_many :impressions
  has_many :reactions


  private



end
