class Webmaster < User

  has_many :reactions, :foreign_key => "webmaster_id"
  has_many :customers
  has_many :products
  has_many :impressions
  has_many :reactions

  before_validation :sanitize_website_url

  default_scope { where('admin = ?', false) }

  def self.with_counts(opts = {from:nil, to:nil, order: :impression_count, direction:'DESC'})

    query = "users.*" <<
      ",COUNT(distinct impressions.id) AS impression_count" <<
      ",COUNT(distinct reactions.id) AS reaction_total" <<
      ",(COUNT(distinct reactions.id) / COUNT(distinct impressions.id)) * 100 AS total_ctr"

    ReactionType.all.each do |type|
      query << ",COUNT(distinct case when reactions.reaction_type_id = #{type.id} then reactions.id end) AS type_count_#{type.id}"
    end
    
    select(query).
      joins(:reactions).
      joins(:impressions).
      group("users.id").
      where(
        "reactions.created_at" => opts[:from]..opts[:to],
        "impressions.created_at" => opts[:from]..opts[:to]
      ).order("#{opts[:order]} #{opts[:direction]}")

  end

  protected

  def sanitize_website_url
    return if website_url
    uri = URI.parse(self.website_url)
    self.website_url = uri.host.gsub('\Awww\.', '')
  end

end
