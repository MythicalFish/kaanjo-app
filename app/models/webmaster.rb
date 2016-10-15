class Webmaster < User

  include SharedMethods
  include Calculator

  has_many :reactions, :foreign_key => "webmaster_id"
  has_many :customers
  has_many :products
  has_many :impressions
  has_many :reactions
  has_many :campaigns

  before_create :assign_sid
  before_save :sanitize_website_url
  after_create :create_default_campaign

  default_scope { where('admin = ?', false) }

  def create_default_campaign
    unless campaigns.any?
      campaigns << Campaign.new_from_default(1)
      save
    end
  end

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
