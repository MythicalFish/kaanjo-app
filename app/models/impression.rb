class Impression < ActiveRecord::Base

  belongs_to :product, counter_cache: true
  belongs_to :customer

end
