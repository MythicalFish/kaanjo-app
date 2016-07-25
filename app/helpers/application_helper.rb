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
    elsif selected_date[:secs] == 'range'
      Time.parse(session[:f])
    else
      Time.now - selected_date[:secs]
    end
  end

  def to_date
    if selected_date[:secs] == 'today'
      Time.now.end_of_day
    elsif selected_date[:secs] == 'range'
      Time.parse(session[:u])
    else
      Time.now
    end
  end

  def selected_date
    if params[:t]
      session[:t] = params[:t]
      session[:f] = params[:f] if params[:f]
      session[:u] = params[:u] if params[:u]
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
      'range' =>  { label: "Custom: #{session[:f]} until #{session[:u]}",  secs: 'range' },
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

  def body_class
    unless current_user
      'bg-intro'
    end
  end

  def sort_link attribute, label
    
    direction = 'down'
    link_class = 'sorter-down'

    if params[:d] == 'down'
      direction = 'up'
      link_class = 'sorter-up'
    end

    if params[:a] == attribute
      link_class << ' current'
    end
        
    url = url_replace(request.original_url,{d:direction,a:attribute})

    render partial: 'shared/sort_link', locals: {url:url,link_class:link_class,label:label}

  end

end
