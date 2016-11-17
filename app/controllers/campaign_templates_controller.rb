class CampaignTemplatesController < CampaignsController

  include EnforceAdmin

  def index
    @title = "Templates"
    @campaigns = find_all
    @body_class = 'container-narrow'
  end

  def show
    @campaign = CampaignTemplate.find(id)
    @title = @campaign.name
  end

end