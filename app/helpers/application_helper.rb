module ApplicationHelper

  def page_title
    return "#{@title} | Reactions Demo" if @title
    if content_for(:page_title)
      content_for(:page_title) << " | Reactions Demo"
    else
      "~ | Reactions Demo"
    end
  end

  def site_name
    Rails.configuration.site_name
  end

  def cp(path)
    "current" if current_page?(path)
  end

  def cc(name)
    "current" if controller_name == name
  end

  def url_replace( target, *args )
    uri = URI.parse(URI::DEFAULT_PARSER.escape target)
    uri.path = CGI.escape(args.first)  if args.first.kind_of?(String)
    if args.last.kind_of?(Hash)
      query = uri.query ? CGI.parse(uri.query) : {}
      args.last.each{ |k,v| v ? query[k.to_s] = v.to_s : query.delete(k.to_s) }
      uri.query = query.any? ? URI.encode_www_form(query) : nil
    end
    CGI.unescape(uri.to_s)
  end

  def devise_mapping
    Devise.mappings[:user]
  end

  def resource_name
    devise_mapping.name
  end

  def resource_class
    devise_mapping.to
  end

  def ctr(impressions,reactions)
    ctr = ((reactions.to_f / impressions.to_f) * 100).round(3) 
    return 0 unless ctr > 0
    ctr
  end

  def body_class
    unless current_user
      'bg-intro'
    end
  end

end
