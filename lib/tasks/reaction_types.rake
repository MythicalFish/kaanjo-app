task update_types: :environment do 

  ATTRIBUTES = {
    1 => { 
      name: 'Like',
      message: 'Thanks! You and {number} others also liked this item.',
      message_first: 'Thanks, you are the first person to like this item!'
    },
    2 => { 
      name: 'Love',
      message: 'Thanks! You and {number} others also loved this item.',
      message_first: 'Thanks, you are the first person to love this item!'
    },
    3 => { 
      name: 'Happy owner',
      message: 'Thanks! You and {number} others are also happy owners.',
      message_first: 'Thanks, you are the first happy owner!'
    },
    4 => { 
      name: 'Nice gift',
      message: 'Thanks! Your feedback will help us improve our service and your future experience.',
      message_first: 'Thanks! Your feedback will help us improve our service and your future experience.'
    },
    5 => { 
      name: 'So-so',
      message: 'Thanks! Your opinion matters. Your feedback enables us to improve our service.',
      message_first: 'Thanks! Your opinion matters. Your feedback enables us to improve our service.'
    }
  }

  ReactionType.all.each do |t|
    t.update_attributes!(ATTRIBUTES[t.id])
  end

end
