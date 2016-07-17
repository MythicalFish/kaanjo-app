class Product < ActiveRecord::Base

  has_many :impressions
  has_many :reactions
  belongs_to :webmaster

  def impression_count
    impressions.length
  end

  def reaction_count(type=nil)
    type_id = type.id if type
    type_id = ReactionType.ids unless type_id
    reactions.where(reaction_type_id:type_id).length
  end

  def reaction_totals
    r = {}
    ReactionType.all.each do |type|
      r[type.name] = reaction_total(type)
    end
    r
  end

  def reaction_total type = nil
    # TODO: cache results
    if type
      reactions.where(reaction_type:type).length
    else
      reactions.length
    end
  end

end
