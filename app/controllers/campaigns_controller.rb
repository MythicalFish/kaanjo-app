class CampaignsController < ApplicationController

  respond_to :html

  def index
    @title = "Campaigns"
    @campaigns = find_all
  end

  def show
    
    if admin?
      @campaign = Campaign.find(params[:id]).with_totals(sorted)
    elsif webmaster?
      @campaign = current_webmaster.campaigns.find_by_relative_id(params[:id]).with_totals(sorted)
    end
    
    @current_webmaster = @campaign.webmaster if admin?
    @title = @campaign.name

  end

  def edit
    
    if admin?
      @campaign = Campaign.find(params[:id])
    elsif webmaster?
      @campaign = current_webmaster.campaigns.find_by_relative_id(params[:id])
    end

    @current_webmaster = @campaign.webmaster if admin?
    @title = @campaign.name

  end

  def new
    @campaign = Campaign.new
    @title = "New campaign"
  end

  def update

    if admin?
      @campaign = Campaign.find(params[:id])
    else
      @campaign = current_webmaster.campaigns.find(params[:id])
    end

    was_enabled = @campaign.enabled?
    just_activated = false

    if scenarios_invalid?
      flash[:alert] = "Error: You need at least 2 scenarios"
    elsif @campaign.update_attributes(campaign_params)
      e = @campaign.enabled?
      just_activated = true if e and e != was_enabled
      n = "Campaign updated"
      n = "Great, your campaign is live!" if just_activated  
      flash[:notice] = n
    else
      flash[:alert] = "Error: #{@campaign.errors.full_messages.to_sentence}"
    end

    if admin?
      redirect_to edit_campaign_path(@campaign.id)
    elsif just_activated
      redirect_to implement_campaign_path(@campaign.relative_id)
    else
      redirect_to edit_campaign_path(@campaign.relative_id)
    end

  end

  def create
    
    @campaign = current_webmaster.campaigns.new(campaign_params)

    if @campaign.save
      notice = "Campaign created"
      notice = "Great, your campaign is live!" if @campaign.enabled?
      flash[:notice] = notice
      redirect_to implement_campaign_path(@campaign.relative_id)
    else
      flash[:alert] = "Campaign creation failed: #{@campaign.errors.full_messages.to_sentence}"
      respond_with @campaign, location: new_campaign_path
    end
  end

  def implementation

    if admin?
      @campaign = Campaign.find(params[:id])
    elsif webmaster?
      @campaign = current_webmaster.campaigns.find_by_relative_id(params[:id])
    end

    @title = 'Campaign implementation'

  end

  private

  def find_all
    if admin?
      CampaignTemplate.all
    elsif webmaster?
      current_webmaster.campaigns
    end
  end

  def campaign_params model = :campaign
    params.require(model).permit(
      :name, :description, :question, :social_proof, :site_path, :enabled, :start_date, :end_date,
      :scenarios_attributes => [ :id, :enabled, :label, :emoticon_id, :message, :custom_emoticon ]
    )
  end

  def scenarios_invalid? model = :campaign
    enabled_scenarios = 0
    campaign_params(model)[:scenarios_attributes].select do |k,s|
      enabled_scenarios += 1 if s[:enabled] == 'true'
    end
    return false if enabled_scenarios >= 2
    true
  end

end
