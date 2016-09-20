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

  after_initialize :setup_totals

  attr_accessor :reaction_total, :impression_total, :ctr, 
    :type_total_1, :type_total_2, :type_total_3, :type_total_4, :type_total_5

  def self.with_totals opts = {}
    @@testy = 123
    collection = []
    Webmaster.all.each do |w|
      w.reaction_total = w.get_reaction_total(opts)
      w.type_total_1 = w.get_reaction_total({type:ReactionType.find(1)}.merge(opts))
      w.type_total_2 = w.get_reaction_total({type:ReactionType.find(2)}.merge(opts))
      w.type_total_3 = w.get_reaction_total({type:ReactionType.find(3)}.merge(opts))
      w.type_total_4 = w.get_reaction_total({type:ReactionType.find(4)}.merge(opts))
      w.type_total_5 = w.get_reaction_total({type:ReactionType.find(5)}.merge(opts))
      w.impression_total = w.get_impression_total(opts)
      w.ctr = w.get_ctr(opts)
      collection << w
    end
    collection
  end

  def get_count_for association, opts = {}

    opts = { type: false, day: Date.today }.merge(opts)

    type = opts[:type] ? opts[:type] : 'all'
    association_name = association.model_name.collection

    key = "" <<
      "/webmaster-#{id}" <<
      "/#{association_name}_count" <<
      "/type-#{type}" <<
      "/#{opts[:day].to_s}" # TODO: dont cache current day

    Rails.cache.fetch(key) do
      from = opts[:day].beginning_of_day
      to = opts[:day].end_of_day
      args = { created_at: from..to }
      args[:reaction_type] = opts[:type] if opts[:type]
      association.where(args).length
    end

  end

  def get_total_for association, opts = {}

    opts = { type: false, from: Date.today, to: Date.today }.merge(opts)

    total = 0
    (opts[:from]..opts[:to]).each do |day|
      total += get_count_for(association, { type: opts[:type], day: day })
    end

    total

  end

  def get_reaction_total opts = {}
    get_total_for reactions, opts
  end

  def get_impression_total opts = {}
    get_total_for impressions, opts
  end

  def get_ctr opts = {}
    ctr = ((get_reaction_total(opts).to_f / get_impression_total(opts).to_f) * 100).round(2)
    ctr = 0 unless ctr > 0
    "#{ctr}%"
  end

  private

  def setup_totals
    puts @@testy
  end

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
