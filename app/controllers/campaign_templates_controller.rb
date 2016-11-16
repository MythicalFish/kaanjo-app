class CampaignTemplatesController < CampaignsController

  include EnforceAdmin

    def index
    @title = "Templates"
    @campaigns = find_all
    @body_class = 'container-narrow'
  end

end