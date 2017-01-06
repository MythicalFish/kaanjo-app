module CampaignMethods
  extend ActiveSupport::Concern
  included do
    
  def status
    return 'Running' if running?
    'Not running'
  end

  end
end