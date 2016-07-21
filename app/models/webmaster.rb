class Webmaster < User

  has_many :reactions, :foreign_key => "webmaster_id"
  has_many :customers
  has_many :products
  has_many :impressions
  has_many :reactions

  before_validation :smart_add_url_protocol

  default_scope { where('admin = ?', false) }

  def self.with_counts(from,to)
    
    query = "users.*" <<
      ",COUNT(impressions.id) as impression_count" <<
      ",COUNT(reactions.id) as reaction_total"

    ReactionType.all.each do |type|
      query << ",COUNT(distinct case when reactions.reaction_type_id = #{type.id} then reactions.id end) AS type_count_#{type.id}"
    end
    
    select(query).
      joins(:reactions).
      joins(:impressions).
      group("users.id").
      where(created_at:from..to)

  end

  def impression_count(from,to)
    impressions.where(created_at:from..to).length
  end

  def reaction_count(from,to,type=nil)
    type_id = type.id if type
    type_id = ReactionType.ids unless type_id
    reactions.where(reaction_type_id:type_id,created_at:from..to).length
  end

  def ctr(from,to,type=nil)
    ctr = ((reaction_count(from,to).to_f / impression_count(from,to).to_f) * 100).round(3) 
    return 0 unless ctr > 0
    ctr
  end

  protected

  def smart_add_url_protocol
    unless self.website[/\Ahttp:\/\//] || self.website[/\Ahttps:\/\//]
      self.website = "http://#{self.website}"
    end
  end

end
