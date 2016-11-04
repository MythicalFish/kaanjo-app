namespace :default_campaigns do
  task reset: :environment do 
    
    DefaultCampaign.all.delete_all

    c = DefaultCampaign.create( 
      name: 'Default 1', 
      enabled: true, 
      question: 'How does this item make you feel?',
      social_proof: 'Already {count} people have shared their opinion with {company}.'
    )

    c.scenarios.create([
      {emoticon_id: 1},
      {emoticon_id: 2},
      {emoticon_id: 3},
      {emoticon_id: 4},
      {emoticon_id: 5}
    ])

  end
end