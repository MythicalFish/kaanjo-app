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
    if params[:timeago]
      Time.now - date_ranges[params[:timeago]][:secs]
    else
      Time.now - (30*60)
    end
  end

  def to_date
    Time.now
  end

  def date_ranges
    {
      '05' => { label: '30 mins',  secs: 60*30 },
      '1'  => { label: '1 hour',   secs: 60*60 },
      '3'  => { label: '3 hours',  secs: 60*60*3 },
      '6'  => { label: '6 hours',  secs: 60*60*6 },
      '12' => { label: '12 hours', secs: 60*60*12 },
      '24' => { label: '24 hours', secs: 60*60*24 },
      '48' => { label: '48 hours', secs: 60*60*48 }
    }
  end

end
