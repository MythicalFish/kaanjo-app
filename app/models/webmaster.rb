class Webmaster < User

  include SharedQueries
  include SharedMethods

  has_many :reactions, :foreign_key => "webmaster_id"
  has_many :customers
  has_many :products
  has_many :impressions
  has_many :reactions

  before_create :assign_sid 
  before_validation :sanitize_website_url

  default_scope { where('admin = ?', false) }

  protected

  def sanitize_website_url
    return if website_url
    uri = URI.parse(self.website_url)
    self.website_url = uri.host.gsub('\Awww\.', '')
  end

end
