class Webmaster < User

  has_many :reactions, :foreign_key => "webmaster_id"
  has_many :customers
  has_many :products
  has_many :impressions
  has_many :reactions

  before_validation :smart_add_url_protocol

  default_scope { where('admin = ?', false) }

  def impression_count(from,to)
    impressions.where(created_at:from..to).length
  end

  def reaction_count(from,to,type=nil)
    type_id = type.id if type
    type_id = ReactionType.ids unless type_id
    reactions.where(reaction_type_id:type_id,created_at:from..to).length
  end

  def ctr(from,to,type=nil)
    ((reaction_count(from,to).to_f / impression_count(from,to).to_f) * 100).round(3)
  end

  protected

  def smart_add_url_protocol
    unless self.website[/\Ahttp:\/\//] || self.website[/\Ahttps:\/\//]
      self.website = "http://#{self.website}"
    end
  end

end
