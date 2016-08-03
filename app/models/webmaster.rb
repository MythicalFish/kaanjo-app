class Webmaster < User

  include ReactionQueries

  has_many :reactions, :foreign_key => "webmaster_id"
  has_many :customers
  has_many :products
  has_many :impressions
  has_many :reactions

  before_validation :sanitize_website_url

  default_scope { where('admin = ?', false) }

  def impression_count from, to
    impressions.where(created_at:from..to).length
  end

  def reaction_total from, to
    reactions.where(created_at:from..to).length
  end

  def reaction_counts from, to
    ReactionType.select( 
      "name," <<
      "COUNT(reactions.id) AS count" ).
      joins(:reactions).
      where(
        "reactions.webmaster_id" => self.id,
        "reactions.created_at" => from..to
      ).
      group("reaction_types.id")
  end

  protected

  def sanitize_website_url
    return if website_url
    uri = URI.parse(self.website_url)
    self.website_url = uri.host.gsub('\Awww\.', '')
  end

end
