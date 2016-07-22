class Webmaster < User

  has_many :reactions, :foreign_key => "webmaster_id"
  has_many :customers
  has_many :products
  has_many :impressions
  has_many :reactions

  before_validation :sanitize_website_url

  default_scope { where('admin = ?', false) }

  def self.with_counts(from,to,order=:impression_count,direction='DESC')
    
    query = "users.*" <<
      ",COUNT(distinct impressions.id) as impression_count" <<
      ",COUNT(distinct reactions.id) as reaction_total"

    ReactionType.all.each do |type|
      query << ",COUNT(distinct case when reactions.reaction_type_id = #{type.id} then reactions.id end) AS type_count_#{type.id}"
    end
    
    select(query).
      joins(:reactions).
      joins(:impressions).
      group("users.id").
      where("reactions.created_at BETWEEN '#{from}' AND '#{to}'").
      order("#{order} #{direction}")

  end

  protected

  def sanitize_website_url
    return if website_url
    uri = URI.parse(self.website_url)
    self.website_url = uri.host.gsub('\Awww\.', '')
  end

end
