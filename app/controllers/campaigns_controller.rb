class CampaignsController < ApplicationController

  respond_to :html

  def index
    @title = "Campaigns"
    @campaigns = find_all
  end

  def show
    @campaign = find(params[:id])
    @title = @campaign.name
  end

  def edit
    @campaign = find(params[:id])
    @title = @campaign.name
  end

  def new
    @campaign = Campaign.new if webmaster?
    @campaign = CampaignTemplate.new if admin?
    @title = "New campaign"
  end

  def update

    @campaign = find(params[:id])

    if scenarios_invalid?
      flash[:alert] = "Error: You need at least 2 scenarios"
    elsif @campaign.update_attributes(campaign_params)
      flash[:notice] = 'Campaign updated'
    else
      flash[:alert] = "Error: #{@campaign.errors.full_messages.to_sentence}"
    end

    if admin?
      redirect_to edit_campaign_template_path(@campaign)
    elsif webmaster?
      redirect_to edit_campaign_path(@campaign)
    end

  end

  def create
    
    if admin?
      @campaign = CampaignTemplate.new(campaign_params)
    elsif webmaster?
      @campaign = Template.new(campaign_params)
    end

    if @campaign.save
      flash[:notice] = "Campaign created"
      redirect_to campaigns_path if webmaster?
      redirect_to campaign_templates_path if admin?
    else
      flash[:alert] = "Campaign creation failed: #{@campaign.errors.full_messages.to_sentence}"
      respond_with @campaign, location: new_campaign_path
    end
  end

  def destroy
    @campaign = find(params[:id])
    @campaign.update_attributes(deleted:true)
    flash[:notice] = 'Campaign deleted'
    redirect_to campaigns_path if webmaster?
    redirect_to campaign_templates_path if admin?
  end

  private

  def find id
    if admin?
      CampaignTemplate.find(id)
    elsif webmaster?
      current_webmaster.campaigns.find_by_relative_id(id)
    end
  end

  def find_all
    if admin?
      CampaignTemplate.all
    elsif webmaster?
      current_webmaster.campaigns
    end
  end

  def campaign_params
    model_name = admin? ? :campaign_template : :campaign
    params.require(model_name).permit(
      :name, :description, :question, :social_proof, :site_path, :enabled, :start_date, :end_date,
      :scenarios_attributes => [ :id, :enabled, :label, :emoticon_id, :message ]
    )
  end

  def scenarios_invalid?
    enabled_scenarios = 0
    campaign_params[:scenarios_attributes].select do |k,s|
      enabled_scenarios += 1 if s[:enabled] == 'true'
    end
    return false if enabled_scenarios >= 2
    true
  end

end
