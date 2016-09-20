class Webmaster < User

  include SharedQueries
  include SharedMethods

  has_many :reactions, :foreign_key => "webmaster_id"
  has_many :customers
  has_many :products
  has_many :impressions
  has_many :reactions

  before_create :assign_sid
  before_save :sanitize_website_url

  default_scope { where('admin = ?', false) }


  def count_for association, opts = { type: false, day: Date.today }

    type = opts[:type] ? opts[:type] : 'all'
    association_name = association.model_name.collection

    key = "" <<
      "/webmaster-#{id}" <<
      "/#{association_name}_count" <<
      "/type-#{type}" <<
      "/#{opts[:day].to_s}"

    Rails.cache.fetch(key) do
      from = opts[:day].beginning_of_day
      to = opts[:day].end_of_day
      args = { created_at: from..to }
      args[:reaction_type] = opts[:type] if opts[:type]
      association.where(args).length
    end

  end

  def total_for association, opts = { type: false, from: Date.today, to: Date.today }
    total = 0
    (opts[:from]..opts[:to]).each do |day|
      total += count_for(association, { type: opts[:type], day: day })
    end
    total
  end

  def reaction_total opts = { type: false, from: Date.today, to: Date.today }
    total_for reactions, opts
  end

  def impression_total opts = { from: Date.today, to: Date.today }
    total_for impressions, opts
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
