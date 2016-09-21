module DateHelper
 
  def from_date
    if selected_date[:secs] == 'today'
      Date.today
    elsif selected_date[:secs] == 'yesterday'
      Date.yesterday
    elsif selected_date[:secs] == 'range'
      Date.parse(session[:f])
    else
      (Time.now - selected_date[:secs]).to_date
    end
  end

  def to_date
    if selected_date[:secs] == 'today'
      Date.today
    elsif selected_date[:secs] == 'yesterday'
      Date.yesterday
    elsif selected_date[:secs] == 'range'
      Date.parse(session[:u])
    else
      Date.today
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
      'today' =>      { label: "Today (#{Date.today.strftime('%e %b')})", secs: 'today' },
      'yesterday' =>  { label: "Yesterday", secs: 'yesterday' },
      '3days' =>      { label: 'Last 3 days', secs: 60*60*24*3 },
      '7days' =>      { label: 'Last 7 days', secs: 60*60*24*7 },
      '30days' =>     { label: 'Last 30 days', secs: 60*60*24*30 },
      'range' =>      { label: "#{session[:f]} - #{session[:u]}",  secs: 'range' }
    }
  end

end
