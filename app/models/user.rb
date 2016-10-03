class User < ActiveRecord::Base
  
  include SharedMethods
  
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

end
