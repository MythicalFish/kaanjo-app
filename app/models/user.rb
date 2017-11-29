class User < ActiveRecord::Base
    
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  validates :first_name, length: {minimum: 2, maximum: 12}
  validates :last_name, length: {minimum: 2, maximum: 30}

  validate :webmaster_validations

  def webmaster_validations
    return if admin?
    if !website_url || website_url.length < 6 || website_url.length > 60
      errors.add(:website_url,'Website URL must be between 6 and 60 characters')
    end
    if !website_name || website_name.length < 3 || website_name.length > 60
      errors.add(:website_name,'Website URL must be between 3 and 60 characters')
    end
  end

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
