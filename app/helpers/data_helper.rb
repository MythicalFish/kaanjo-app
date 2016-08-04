module DataHelper
  
  def ctr_for object
    if object.respond_to?(:total_ctr)
      return "#{object.total_ctr}%"
    elsif object.respond_to?(:impression_count) && object.respond_to?(:reaction_total)
      ctr = ((object.reaction_total.to_f / object.impression_count.to_f) * 100).round(3) 
      ctr = 0 unless ctr > 0
      return "#{ctr}%"
    else 
      return '?'
    end
  end

end
