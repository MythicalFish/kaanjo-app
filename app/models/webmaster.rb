class Webmaster < User

  has_many :reactions, :foreign_key => "webmaster_id"

  default_scope { where('admin = ?', false) }

  def customers
    #self.reactions
  end

  def products(

  from: Time.new(1970), 
  to: Time.now, 
  order_by: 'count(*)', 
  order_direction: 'DESC', 
  reaction_type_ids: ReactionType.ids )


  reactions.
    joins(:reaction_type).
    where('
      reactions.created_at BETWEEN ? AND ? and
      reaction_types.id IN (?)',
      from,to,
      reaction_type_ids
    ).
    group('product').
    order("#{order_by} #{order_direction}")

  end

end
