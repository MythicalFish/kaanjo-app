task update_dates: :environment do 
  Impression.all.each do |i|
    t = Time.now - rand(0..172800)
    i.created_at = t
    i.save
  end

  Reaction.all.each do |i|
    t = Time.now - rand(0..172800)
    i.created_at = t
    i.save
  end
end
