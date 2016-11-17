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

  def update

    @campaign = CampaignTemplate.find(params[:id])

    if scenarios_invalid? :campaign_template
      flash[:alert] = "Error: You need at least 2 scenarios"
    elsif @campaign.update_attributes(campaign_params(:campaign_template))
      flash[:notice] = 'Template updated'
    else
      flash[:alert] = "Error: #{@campaign.errors.full_messages.to_sentence}"
    end

    redirect_to edit_campaign_template_path(@campaign)

  end

  def create

    @campaign = CampaignTemplate.new(campaign_params(:campaign_template))

    if @campaign.save
      flash[:notice] = "Template created"
      redirect_to campaign_templates_path
    else
      flash[:alert] = "Template creation failed: #{@campaign.errors.full_messages.to_sentence}"
      respond_with @campaign, location: new_campaign_template_path
    end

  end

end