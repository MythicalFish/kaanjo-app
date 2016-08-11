module ClientHelper
  
  def button_class r
    c = "kaanjo-reaction"
    c << " kaanjo-selected" if r == @reaction_type
    c
  end

  def emoticon_url reaction_type
    "http://#{site_url}/emoticons/#{reaction_type.id}.svg"
  end

  def site_url
    Rails.configuration.site_url
  end

end
