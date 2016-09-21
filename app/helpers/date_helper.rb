module DateHelper
 
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
      'range' =>  { label: "#{session[:f]} - #{session[:u]}",  secs: 'range' },
      '05' =>     { label: 'Last 30 minutes',  secs: 60*30 },
      '1'  =>     { label: 'Last hour',   secs: 60*60 },
      '3'  =>     { label: 'Last 3 hours',  secs: 60*60*3 },
      '6'  =>     { label: 'Last 6 hours',  secs: 60*60*6 },
      '12' =>     { label: 'Last 12 hours', secs: 60*60*12 },
      '24' =>     { label: 'Last 24 hours', secs: 60*60*24 },
      '48' =>     { label: 'Last 48 hours', secs: 60*60*48 }
    }
  end

end
