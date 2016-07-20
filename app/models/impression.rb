class Impression < ActiveRecord::Base

  belongs_to :webmaster
  belongs_to :product
  belongs_to :customer

end
