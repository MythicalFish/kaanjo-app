namespace :scenarios do

  task reset: :environment do 

    scenarios = [
      { 
        label: 'Like',
        message: 'Thanks! You and {number} others also liked this item.'
      },{ 
        label: 'Love',
        message: 'Thanks! You and {number} others also loved this item.'
      },{ 
        label: 'Happy owner',
        message: 'Thanks! You and {number} others are also happy owners.'
      },{ 
        label: 'So-so',
        message: 'Thanks! Your opinion matters. Your feedback enables us to improve our service.'
      },{ 
        label: 'Nice gift',
        message: 'Thanks! Your feedback will help us improve our service and your future experience.'
      }
    ]

    Scenario.all.delete_all
    ActiveRecord::Base.connection.execute('ALTER TABLE scenarios AUTO_INCREMENT = 1')

    scenarios.each_with_index do |r,i|
      Scenario.create({
        label: r[:label],
        message: r[:message],
        emoticon_id: i + 1
      })
    end

  end

end