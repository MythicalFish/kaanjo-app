module ApplicationHelper

  def page_title
    return "#{@title} | Reactions Demo" if @title
    if content_for(:page_title)
      content_for(:page_title) << " | Reactions Demo"
    else
      "~ | Reactions Demo"
    end
  end

  def current_webmaster
    if current_user && current_user.webmaster?
      Webmaster.find(current_user.id)
    end
  end

  def cp(path)
    "current" if current_page?(path)
  end

  def cc(name)
    "current" if controller_name == name
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
    if selected_date[:secs] == 'today'
      Time.now.beginning_of_day
    else
      Time.now - selected_date[:secs]
    end
  end

  def to_date
    if selected_date[:secs] == 'today'
      Time.now.end_of_day
    else
      Time.now
    end
  end

  def selected_date
    if params[:t]
      session[:t] = params[:t]
      dates[params[:t]]
    elsif session[:t]
      dates[session[:t]]
    else
      dates['today']
    end
  end

  def dates
    {
      'today' =>  { label: "Today (#{Time.now.strftime('%e %b')})", secs: 'today' },
      '05' =>     { label: 'Last 30 minutes',  secs: 60*30 },
      '1'  =>     { label: 'Last hour',   secs: 60*60 },
      '3'  =>     { label: 'Last 3 hours',  secs: 60*60*3 },
      '6'  =>     { label: 'Last 6 hours',  secs: 60*60*6 },
      '12' =>     { label: 'Last 12 hours', secs: 60*60*12 },
      '24' =>     { label: 'Last 24 hours', secs: 60*60*24 },
      '48' =>     { label: 'Last 48 hours', secs: 60*60*48 }
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

  def ctr(impressions,reactions)
    ctr = ((reactions.to_f / impressions.to_f) * 100).round(3) 
    return 0 unless ctr > 0
    ctr
  end

end
