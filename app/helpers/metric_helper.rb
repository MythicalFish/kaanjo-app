module MetricHelper

  def selected_metric
    if params.key?(:m)
      metrics[params[:m]]
    else
      metrics['ctr']
    end
  end

  def metrics
    {
      'ctr' => { label: 'Overall CTR', key: :ctr },
      'impressions' => { label: 'Impressions', key: :impression_total },
      'reactions' => { label: 'Reactions', key: :reaction_total }
    }
  end

end