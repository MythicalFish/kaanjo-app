class Webmaster < User

  has_many :reactions, :foreign_key => "webmaster_id"
  has_many :customers
  has_many :products
  has_many :impressions
  has_many :reactions

  before_validation :smart_add_url_protocol

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

  def impression_counter(from,to)
    impressions.where(created_at:from..to).length
  end

  def reaction_counter(from,to,type=nil)
    type_id = type.id if type
    type_id = ReactionType.ids unless type_id
    reactions.where(reaction_type_id:type_id,created_at:from..to).length
  end

  protected

  def smart_add_url_protocol
    unless self.website[/\Ahttp:\/\//] || self.website[/\Ahttps:\/\//]
      self.website = "http://#{self.website}"
    end
  end

end
