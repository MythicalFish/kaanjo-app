class Impression < ActiveRecord::Base

  belongs_to :product
  belongs_to :customer

  def self.total from, to
    if from && to
      self.where(created_at:from..to).length
    else
      self.length
    end
  end

end
