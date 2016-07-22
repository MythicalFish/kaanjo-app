class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable#,
         #:confirmable

  validates :first_name, length: {minimum: 2, maximum: 12}
  validates :last_name, length: {minimum: 2, maximum: 20}
  validates :website_url, length: {minimum: 6, maximum: 25}
  validates :website_name, length: {minimum: 3, maximum: 25}

  def webmaster?
    !admin?
  end

  def name
    "#{first_name} #{last_name}"
  end

end
