namespace :reaction_types do

  task import: :environment do 

    data = [
      { 
        name: 'Like',
        message: 'Thanks! You and {number} others also liked this item.',
        message_first: 'Thanks, you are the first person to like this item!'
      },{ 
        name: 'Love',
        message: 'Thanks! You and {number} others also loved this item.',
        message_first: 'Thanks, you are the first person to love this item!'
      },{ 
        name: 'Happy owner',
        message: 'Thanks! You and {number} others are also happy owners.',
        message_first: 'Thanks, you are the first happy owner!'
      },{ 
        name: 'Nice gift',
        message: 'Thanks! Your feedback will help us improve our service and your future experience.',
        message_first: 'Thanks! Your feedback will help us improve our service and your future experience.'
      },{ 
        name: 'So-so',
        message: 'Thanks! Your opinion matters. Your feedback enables us to improve our service.',
        message_first: 'Thanks! Your opinion matters. Your feedback enables us to improve our service.'
      }
    ]

  end

end