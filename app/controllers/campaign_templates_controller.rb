class CampaignTemplatesController < CampaignsController

  private

  def campaign_params
    params.require(:campaign_template).permit(
      :name, :description, :question, :social_proof, :site_path, :enabled, :start_date, :end_date,
      :scenarios_attributes => [ :label, :emoticon_id, :message ]
    )
  end

end