class Customer < ActiveRecord::Base

  has_many :impressions
  has_many :reactions

  before_save :generate_sid

  private

  def generate_sid
    begin
      secure_id = SecureRandom.hex(12)
    end while Customer.where(:sid => secure_id).exists?
    self.sid = secure_id
  end

end
