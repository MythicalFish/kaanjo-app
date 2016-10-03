class User < ActiveRecord::Base
    
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  validates :first_name, length: {minimum: 2, maximum: 12}
  validates :last_name, length: {minimum: 2, maximum: 30}
  validates :website_url, length: {minimum: 6, maximum: 60}
  validates :website_name, length: {minimum: 3, maximum: 60}

  before_create :assign_sid

  def webmaster?
    !admin?
  end

  def name
    "#{first_name} #{last_name}"
  end

  def subtitle
    if admin?
      "Administrator"
    else
      website_name
    end
  end

  private

  def assign_sid
    return if self.sid
    begin
      secure_id = SecureRandom.hex(12)
    end while Product.where(:sid => secure_id).exists?
    self.sid = secure_id
  end

end
