# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'seeding data'

a = Admin.new({ email:'jake@freshsector.com', password:'test1234', first_name: 'Jake',        last_name: 'Broughton'  })
a.save!(validate:false)

a = Admin.new({ email:'adrien_lepert@yahoo.fr', password:'test1234', first_name: 'Adrien',        last_name: 'Lepert'  })
a.save!(validate:false)

Webmaster.create([
  { email:'adidas@test.com', password:'test1234', website_url: 'http://localhost:3000', website_name: 'Adidas', first_name: 'Adidas', last_name: 'Test', sid: '7a9fddb8909b897e3bd07dea' },
  { email:'jake@demo-shop.vertaxe.com', password:'test1234', website_url: 'http://demo-shop.vertaxe.com', website_name: 'Demo Shop', first_name: 'Jake',        last_name: 'Broughton' },
  { email:'jake@localhost:8000', password:'test1234',        website_url: 'http://localhost:8000',        website_name: 'localhost', first_name: 'Jake',        last_name: 'Broughton' },
  { email:'webmaster4@site4.com', password:'test1234',       website_url: 'http://site4.com',             website_name: 'Site 4', first_name: 'Webmaster',   last_name: 'Four' },
  { email:'webmaster5@site5.com', password:'test1234',       website_url: 'http://site5.com',             website_name: 'Site 5', first_name: 'Webmaster',   last_name: 'Five' },
  { email:'webmaster6@site6.com', password:'test1234',       website_url: 'http://site6.com',             website_name: 'Site 6', first_name: 'Webmaster',   last_name: 'Six' },
  { email:'webmaster7@site7.com', password:'test1234',       website_url: 'http://site7.com',             website_name: 'Site 7', first_name: 'Webmaster',   last_name: 'Seven' },
  { email:'webmaster8@site8.com', password:'test1234',       website_url: 'http://site8.com',             website_name: 'Site 8', first_name: 'Webmaster',   last_name: 'Eight' },
  { email:'webmaster9@site9.com', password:'test1234',       website_url: 'http://site9.com',             website_name: 'Site 9', first_name: 'Webmaster',   last_name: 'Nine' },
  { email:'webmaster10@site10.com', password:'test1234',     website_url: 'http://site10.com',            website_name: 'Site 10', first_name: 'Webmaster',   last_name: 'Ten' },
  { email:'webmaster11@site11.com', password:'test1234',     website_url: 'http://site11.com',            website_name: 'Site 11', first_name: 'Webmaster',   last_name: 'Eleven' },
  { email:'webmaster12@site12.com', password:'test1234',     website_url: 'http://site12.com',            website_name: 'Site 12', first_name: 'Webmaster',   last_name: 'Twelve' },
  { email:'webmaster13@site13.com', password:'test1234',     website_url: 'http://site13.com',            website_name: 'Site 13', first_name: 'Webmaster',   last_name: 'Thirteen' },
  { email:'webmaster14@site14.com', password:'test1234',     website_url: 'http://site14.com',            website_name: 'Site 14', first_name: 'Webmaster',   last_name: 'Fourteen' },
  { email:'webmaster15@site15.com', password:'test1234',     website_url: 'http://site15.com',            website_name: 'Site 15', first_name: 'Webmaster',   last_name: 'Fifteen' },
  { email:'webmaster16@site16.com', password:'test1234',     website_url: 'http://site16.com',            website_name: 'Site 16', first_name: 'Webmaster',   last_name: 'Sixteen' },
  { email:'webmaster17@site17.com', password:'test1234',     website_url: 'http://site17.com',            website_name: 'Site 17', first_name: 'Webmaster',   last_name: 'Seventeen' },
  { email:'webmaster18@site18.com', password:'test1234',     website_url: 'http://site18.com',            website_name: 'Site 18', first_name: 'Webmaster',   last_name: 'Eighteen' },
  { email:'webmaster19@site19.com', password:'test1234',     website_url: 'http://site19.com',            website_name: 'Site 19', first_name: 'Webmaster',   last_name: 'Nineteen' },
  { email:'webmaster20@site20.com', password:'test1234',     website_url: 'http://site20.com',            website_name: 'Site 20', first_name: 'Webmaster',   last_name: 'Twenty' }
])

User.all.each do |u|
  u.confirmed_at = Time.now
  u.save(validate:false)
end

CUSTOMER_IDS = [123,456,789,111,222,333]
DEVICES = ['Test device 1','Test device 2','Test device 3']

Webmaster.all.each do |w|

  w.products.create([
    { name: 'Macbook Pro', url: 'https://www.amazon.co.uk/Apple-MacBook-Display-MJLQ2B-Storage/dp/B00Y98VHGK'},
    { name: 'Olympus Tough TG-4 Camera - Red', url: 'https://www.amazon.co.uk/Olympus-Tough-TG-4-Camera-Red/dp/B00VWJYJEG'},
    { name: 'Olympus Tough TG-4 Camera - Black', url: 'https://www.amazon.co.uk/Olympus-Tough-TG-4-Camera-Black/dp/B00VWJYJPK'},
    { name: 'Sandisk 32GB Ultra SDHC Memory Card', url: 'https://www.amazon.co.uk/Sandisk-Ultra-Memory-Olympus-Camera/dp/B00HAJDK7E'},
    { name: 'Amazon Fire TV', url: 'https://www.amazon.co.uk/dp/B00UH2O6T2'},
    { name: 'Mighty Mouse', url: 'https://www.amazon.co.uk/Apple-MB829Z-A-Magic-Mouse/dp/B002NX0M8C'},
    { name: 'Asus Ultra 4K Monitor', url: 'https://www.amazon.co.uk/Asus-PB287Q-Widescreen-Ultra-Monitor/dp/B00JEZTC3I'}
  ])

  w.products.all.each do |p|


    rand(51..400).times do
      t = Time.now - rand(0..172800)
      p.impressions.create(customer_id:CUSTOMER_IDS.sample,device_type:DEVICES.sample,created_at:t)
    end

    rand(2..20).times do
      t = Time.now - rand(0..172800)
      p.reactions.create(reaction_type_id: rand(1..5),customer_id:CUSTOMER_IDS.sample,created_at:t,device_type:DEVICES.sample)
    end

  end
end

ReactionType.create([
  { 
    name: 'Like',
    message: 'Thanks! You and {number} others also liked this item.',
    message_first: 'Thanks, you are the first person to like this item!'
  },
  { 
    name: 'Love',
    message: 'Thanks! You and {number} others also loved this item.',
    message_first: 'Thanks, you are the first person to love this item!'
  },
  { 
    name: 'Happy owner',
    message: 'Thanks! You and {number} others are also happy owners.',
    message_first: 'Thanks, you are the first happy owner!'
  },
  { 
    name: 'Nice gift',
    message: 'Thanks! Your feedback will help us improve our service and your future experience.',
    message_first: 'Thanks! Your feedback will help us improve our service and your future experience.'
  },
  { 
    name: 'So-so',
    message: 'Thanks! Your opinion matters. Your feedback enables us to improve our service.',
    message_first: 'Thanks! Your opinion matters. Your feedback enables us to improve our service.'
  }
])
