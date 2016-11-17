class CampaignTemplatesController < CampaignsController

  include EnforceAdmin

  def index
    @title = "Templates"
    @campaigns = find_all
    @body_class = 'container-narrow'
  end

  def edit
    @body_class = 'container-narrow'
    @campaign = CampaignTemplate.find(params[:id])
    @title = @campaign.name
  end

  def new
    @body_class = 'container-narrow'
    @campaign = CampaignTemplate.new
    @title = "New template"
  end

end