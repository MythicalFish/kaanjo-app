namespace :reaction_types do

  task reset: :environment do 

    reaction_types = [
      { 
        label: 'Like',
        message: 'Thanks! You and {number} others also liked this item.',
        message_first: 'Thanks, you are the first person to like this item!'
      },{ 
        label: 'Love',
        message: 'Thanks! You and {number} others also loved this item.',
        message_first: 'Thanks, you are the first person to love this item!'
      },{ 
        label: 'Happy owner',
        message: 'Thanks! You and {number} others are also happy owners.',
        message_first: 'Thanks, you are the first happy owner!'
      },{ 
        label: 'So-so',
        message: 'Thanks! Your opinion matters. Your feedback enables us to improve our service.',
        message_first: 'Thanks! Your opinion matters. Your feedback enables us to improve our service.'
      },{ 
        label: 'Nice gift',
        message: 'Thanks! Your feedback will help us improve our service and your future experience.',
        message_first: 'Thanks! Your feedback will help us improve our service and your future experience.'
      }
    ]

    ReactionType.all.delete_all
    ActiveRecord::Base.connection.execute('ALTER TABLE reaction_types AUTO_INCREMENT = 1')

    reaction_types.each_with_index do |r,i|
      ReactionType.create({
        label: r[:label],
        message: r[:message],
        message_first: r[:message_first],
        emoticon_id: i + 1
      })
    end

  end

end