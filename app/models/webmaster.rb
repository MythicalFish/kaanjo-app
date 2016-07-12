class Webmaster < User

  has_many :reactions, :foreign_key => "webmaster_id"

  default_scope { where('admin = ?', false) }

  def customers
    #self.reactions
  end

  def products(

  from:               Time.new(1970), 
  to:                 Time.now.end_of_day, 
  order_by:           'count(*)', 
  order_direction:    'DESC', 
  reaction_type_ids:  ReactionType.ids )


    products = reactions.
      where('
        created_at BETWEEN ? AND ? and
        reaction_type_id IN (?)',
        from,to,
        reaction_type_ids
      ).
      group(['product','reaction_type_id']).
      order("#{order_by} #{order_direction}").
      count

    results = {}

    products.each do |p,count|

      product = p[0]
      reaction_type = ReactionType.find(p[1]).name

      results[product] ||= {}
      results[product]['Impressions'] ||= 0
      results[product]['Reactions'] ||= 0

      results[product][reaction_type] = count
      results[product]['Impressions'] += count
      results[product]['Reactions'] += count unless reaction_type == 'None'

    end

    ReactionType.all.each do |r|
      results.each do |product,counts|
        results[product][r.name] ||= 0
      end
    end

    results

  end

end
