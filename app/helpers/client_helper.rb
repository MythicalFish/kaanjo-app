module ClientHelper
  
  def button_class r
    c = "kaanjo-reaction"
    c << " kaanjo-selected" if r == @reaction.try(:scenario)
    c
  end

  def emoticon_url scenario
    "http://#{site_url}/images/emoticons/#{scenario.id}.svg"
  end

  def static_asset_url filename
    "http://#{site_url}/images/#{filename}"
  end

  def site_url
    Rails.configuration.site_url
  end

end
