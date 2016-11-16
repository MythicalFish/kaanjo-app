module CampaignMethods
  extend ActiveSupport::Concern
  included do
    
  def status
    return 'active' if enabled?
    'inactive'
  end

  end
end