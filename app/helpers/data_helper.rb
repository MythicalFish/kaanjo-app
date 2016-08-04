module DataHelper
  
  def ctr_for object
    if defined?(object.total_ctr)
      return "#{object.total_ctr}%"
    elsif defined?(object.impression_count) && defined?(object.reaction_count)
      ctr = ((object.reaction_count.to_f / object.impression_count.to_f) * 100).round(3) 
      ctr = 0 unless ctr > 0
      return "#{ctr}%"
    else 
      return '?'
    end
  end

end
