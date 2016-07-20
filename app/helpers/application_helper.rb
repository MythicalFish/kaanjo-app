module ApplicationHelper

  def current_webmaster
    if current_user && current_user.webmaster?
      Webmaster.find(current_user.id)
    end
  end

  def cp(path)
    "current" if current_page?(path)
  end

  def date_range_url(from,to)
    u = request.original_url
    u = url_replace(u,{from:from.to_i})
    url_replace(u,{to:to.to_i})
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

  def from_date
    Time.now - selected_date_range[:secs]
  end

  def to_date
    Time.now
  end

  def selected_date_range
    if params[:timeago]
      session[:timeago] = params[:timeago]
      date_ranges[params[:timeago]]
    elsif session[:timeago]
      date_ranges[session[:timeago]]
    else
      date_ranges['05']
    end
  end

  def date_ranges
    {
      '05' => { label: 'Last 30 minutes',  secs: 60*30 },
      '1'  => { label: 'Last hour',   secs: 60*60 },
      '3'  => { label: 'Last 3 hours',  secs: 60*60*3 },
      '6'  => { label: 'Last 6 hours',  secs: 60*60*6 },
      '12' => { label: 'Last 12 hours', secs: 60*60*12 },
      '24' => { label: 'Last 24 hours', secs: 60*60*24 },
      '48' => { label: 'Last 48 hours', secs: 60*60*48 }
    }
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

end
