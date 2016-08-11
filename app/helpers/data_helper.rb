module DataHelper
  
  def ctr_for object
    if object.respond_to?(:total_ctr)
      return "#{object.total_ctr}%"
    elsif object.respond_to?(:impression_count) && object.respond_to?(:reaction_total)
      ctr = calculate_ctr(object.reaction_total, object.impression_count)
      ctr = 0 unless ctr > 0
      return "#{ctr}%"
    else 
      return '?'
    end
  end

  def calculate_ctr reactions, impressions
    ((reactions.to_f / impressions.to_f) * 100).round(2) 
  end

end
