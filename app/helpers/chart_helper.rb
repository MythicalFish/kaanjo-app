module ChartHelper

  def chartjs_params_for collection, property = :ctr, label = 'CTR'
    
    c = collection.by_date(from:from_date,to:to_date)
    
    dates = []
    values = []

    aqua = '#0EA0EB'
    gray = '#E9EDEF'

    c.each do |date,value|
      dates << date
      v = value[property]
      values << v
    end

    {
      type: 'line',
      data: {
        labels: dates,
        datasets: [{
          label: label,
          data: values,
          backgroundColor: 'transparent',
          borderColor: gray,
          borderWidth: 4,
          pointBorderColor: aqua,
          pointBackgroundColor: aqua,
          pointHoverBackgroundColor: '#F1F5F8',
          pointRadius: 6,
          lineTension: 0
        }]
    },
    options: {
      scales: {
        yAxes: [{
            ticks: {
              beginAtZero:true
            },
            scaleLabel: 'function(v) { return v+"%"; }'
          }]
        },
        tooltips: {
          backgroundColor: aqua
        }
      }
    }
  end

end