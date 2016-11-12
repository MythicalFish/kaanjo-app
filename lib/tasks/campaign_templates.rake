namespace :campaign_templates do
  task reset: :environment do 
    
    CampaignTemplate.all.delete_all

    c = CampaignTemplate.create( 
      name: 'Default 1', 
      enabled: true, 
      question: 'How does this item make you feel?',
      social_proof: 'Already {count} people have shared their opinion with {company}.',
      scenarios_attributes: [
        {emoticon_id: 1},
        {emoticon_id: 2},
        {emoticon_id: 3},
        {emoticon_id: 4},
        {emoticon_id: 5}
      ] 
    )


  end
end