class Webmaster < User

  include SharedMethods

  has_many :campaigns
  has_many :products,    :through => :campaigns
  has_many :impressions, :through => :products
  has_many :reactions,   :through => :products

  before_create :assign_sid
  before_save :sanitize_website_url

  default_scope { where('admin = ?', false) }

  private


  def sanitize_website_url

    if website_url.include?('http://')
      protocol = 'http://'
    elsif website_url.include?('https://')
      protocol = 'https://'
    else
      protocol = 'http://'
      url = "http://#{website_url}"
      self.website_url = url
    end

    uri = URI.parse(self.website_url)
    url = protocol << uri.host.sub('www.', '')
    url = url << ':3000' if url.include?('localhost')
    self.website_url = url

  end

end
