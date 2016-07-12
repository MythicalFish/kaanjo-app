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
  reaction_types: ReactionType.all )

    o = []

    reactions.
      joins(:reaction_type).
      where(
        created_at: from..to,
        reaction_type: reaction_types
      ).
      group('product').
      order("#{order_by} #{order_direction}").
      count.
    each do |name,count|
      o << { product: name, total_reactions: count }
    end

    o 

  end

end
