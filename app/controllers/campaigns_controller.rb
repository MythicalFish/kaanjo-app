class CampaignsController < ApplicationController

  def index
    @title = "Campaigns"
    @campaigns = current_webmaster.campaigns
  end

  def show
    @campaign = current_webmaster.campaigns.find_by_relative_id(params[:id])
    @title = @campaign.name
  end

  def edit
    @campaign = current_webmaster.campaigns.find_by_relative_id(params[:id])
    @title = @campaign.name
  end

  def new
    @title = "New campaign"
  end

  def update

    @campaign = current_webmaster.campaigns.find_by_relative_id(params[:id])

    if @campaign.update_attributes(campaign_params)
      flash[:notice] = 'Campaign updated'
    else
      flash[:alert] = "Error: #{@campaign.errors.full_messages.to_sentence}"
    end

    redirect_to edit_campaign_path(@campaign)

  end

  def create
    @campaign = current_webmaster.campaigns.new(campaign_params)
    if @campaign.save
      flash[:notice] = "Campaign created"
      redirect_to campaigns_path
    else
      flash[:alert] = "Campaign creation failed: #{@campaign.errors.full_messages.to_sentence}"
      respond_with @campaign, location: new_campaign_path
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(
      :name, :description, :question, :site_path, :enabled, :start_date, :end_date
    )
  end

end
