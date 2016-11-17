module ChartHelper

  def linechart_params_for collection
    
    unless collection.try(:length).to_i >= 1
      if collection.try(:id)
        collection = Object.const_get(collection.model_name.name).where(id:collection.id)
      end
    end

    c = collection.by_date(from:from_date,to:to_date)
    
    dates = []
    values = []

    aqua = '#0EA0EB'
    gray = '#E9EDEF'

    c.each do |date,value|
      dates << date 
      values << value[selected_metric[:key]]
    end

    {
      type: 'line',
      data: {
        labels: dates,
        datasets: [{
          label: selected_metric[:label],
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

  def doughnut_params_for scenarios

    labels = []
    reaction_counts = []

    scenarios.each do |s|
      labels << s.label
      reaction_counts << s.reactions.length
    end

    {
      type: 'doughnut',
      data: {
        labels: labels,
        datasets: [
          {
            data: reaction_counts,
            backgroundColor: [
              "#FF6384",
              "#36A2EB",
              "#FFCE56",
              "#0EA0EB",
              "#1F4C78"
            ]
          }
        ]
      },
      options: {
        cutoutPercentage: 75,
        legend: {
          display: false
        }
      }
    }
  end


end