module DataHelper

  def calculate_ctr reactions, impressions
    ctr = ((reactions.to_f / impressions.to_f) * 100).round(2) 
    return 0 unless ctr > 0
    ctr
  end

end
