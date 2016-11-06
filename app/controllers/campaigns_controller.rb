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

    if @campaign.update_attributes(campaign_params)
      flash[:notice] = 'Campaign updated'
    else
      flash[:alert] = "Error: #{@campaign.errors.full_messages.to_sentence}"
    end

    redirect_to edit_campaign_path(@campaign.relative_id)

  end

  def create
    
    @campaign = find(campaign_params)

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
      CampaignTemplate.find_by_relative_id(id)
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
    params.require(:campaign).permit(
      :name, :description, :question, :social_proof, :site_path, :enabled, :start_date, :end_date,
      :scenarios_attributes => [ :label, :emoticon_id, :message ]
    )
  end

end
