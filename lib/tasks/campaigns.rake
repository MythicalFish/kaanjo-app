task seed_campaigns: :environment do 
  
  DefaultCampaign.all.delete_all
  
  DefaultCampaign.create([
    { title: 'Default 1', enabled: true, question: 'How does this item make you feel?' }
  ])

  reation_type_associations = {
    1 => [1,2,3,4,5]
  }

  reation_type_associations.each do |campaign_id,reaction_type_ids|
    campaign = DefaultCampaign.find(campaign_id)
    reaction_types = ReactionType.find(reaction_type_ids)
    campaign.reaction_types << reaction_types
    campaign.save
  end

  #

  Campaign.all.delete_all

  Webmaster.all.each do |w|
    w.create_default_campaign
  end

end
