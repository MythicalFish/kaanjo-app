class CampaignsController < ApplicationController

  def index
    @title = "Campaigns"
    @campaigns = current_webmaster.campaigns
  end

  def show
    @campaign = Campaign.find(params[:id])
    @title = @campaign.title
  end

end
