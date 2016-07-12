# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

webmasters = User.create([
  { email:'jake@freshsector.com', password:'test1234', admin: true },
  { email:'webmaster1@site1.com', password:'test1234' },
  { email:'webmaster2@site2.com', password:'test1234' },
  { email:'webmaster3@site3.com', password:'test1234' },
  { email:'webmaster4@site4.com', password:'test1234' },
  { email:'webmaster5@site5.com', password:'test1234' },
  { email:'webmaster6@site6.com', password:'test1234' },
  { email:'webmaster7@site7.com', password:'test1234' },
  { email:'webmaster8@site8.com', password:'test1234' },
  { email:'webmaster9@site9.com', password:'test1234' },
  { email:'webmaster10@site10.com', password:'test1234' },
  { email:'webmaster11@site11.com', password:'test1234' },
  { email:'webmaster12@site12.com', password:'test1234' },
  { email:'webmaster13@site13.com', password:'test1234' },
  { email:'webmaster14@site14.com', password:'test1234' },
  { email:'webmaster15@site15.com', password:'test1234' },
  { email:'webmaster16@site16.com', password:'test1234' },
  { email:'webmaster17@site17.com', password:'test1234' },
  { email:'webmaster18@site18.com', password:'test1234' },
  { email:'webmaster19@site19.com', password:'test1234' },
  { email:'webmaster20@site20.com', password:'test1234' }
])

Webmaster.all.each do |w|
  w.reactions.create([

    { reaction_type_id: rand(0..4), customer_id: 123123, product: 'Macbook Pro', product_url: 'https://www.amazon.co.uk/Apple-MacBook-Display-MJLQ2B-Storage/dp/B00Y98VHGK'},
    { reaction_type_id: rand(0..4), customer_id: 123123, product: 'Olympus Tough TG-4 Camera - Red', product_url: 'https://www.amazon.co.uk/Olympus-Tough-TG-4-Camera-Red/dp/B00VWJYJEG'},
    { reaction_type_id: rand(0..4), customer_id: 123123, product: 'Olympus Tough TG-4 Camera - Black', product_url: 'https://www.amazon.co.uk/Olympus-Tough-TG-4-Camera-Black/dp/B00VWJYJPK'},
    { reaction_type_id: rand(0..4), customer_id: 123123, product: 'Sandisk 32GB Ultra SDHC Memory Card', product_url: 'https://www.amazon.co.uk/Sandisk-Ultra-Memory-Olympus-Camera/dp/B00HAJDK7E'},
    { reaction_type_id: rand(0..4), customer_id: 123123, product: 'Amazon Fire TV', product_url: 'https://www.amazon.co.uk/dp/B00UH2O6T2'},
    { reaction_type_id: rand(0..4), customer_id: 123123, product: 'Mighty Mouse', product_url: 'https://www.amazon.co.uk/Apple-MB829Z-A-Magic-Mouse/dp/B002NX0M8C'},
    { reaction_type_id: rand(0..4), customer_id: 123123, product: 'Asus Ultra 4K Monitor', product_url: 'https://www.amazon.co.uk/Asus-PB287Q-Widescreen-Ultra-Monitor/dp/B00JEZTC3I'},

    { reaction_type_id: rand(0..4), customer_id: 456456, product: 'Macbook Pro', product_url: 'https://www.amazon.co.uk/Apple-MacBook-Display-MJLQ2B-Storage/dp/B00Y98VHGK'},
    { reaction_type_id: rand(0..4), customer_id: 456456, product: 'Olympus Tough TG-4 Camera - Red', product_url: 'https://www.amazon.co.uk/Olympus-Tough-TG-4-Camera-Red/dp/B00VWJYJEG'},
    { reaction_type_id: rand(0..4), customer_id: 456456, product: 'Olympus Tough TG-4 Camera - Black', product_url: 'https://www.amazon.co.uk/Olympus-Tough-TG-4-Camera-Black/dp/B00VWJYJPK'},
    { reaction_type_id: rand(0..4), customer_id: 456456, product: 'Sandisk 32GB Ultra SDHC Memory Card', product_url: 'https://www.amazon.co.uk/Sandisk-Ultra-Memory-Olympus-Camera/dp/B00HAJDK7E'},
    { reaction_type_id: rand(0..4), customer_id: 456456, product: 'Amazon Fire TV', product_url: 'https://www.amazon.co.uk/dp/B00UH2O6T2'},
    { reaction_type_id: rand(0..4), customer_id: 456456, product: 'Mighty Mouse', product_url: 'https://www.amazon.co.uk/Apple-MB829Z-A-Magic-Mouse/dp/B002NX0M8C'},
    { reaction_type_id: rand(0..4), customer_id: 456456, product: 'Asus Ultra 4K Monitor', product_url: 'https://www.amazon.co.uk/Asus-PB287Q-Widescreen-Ultra-Monitor/dp/B00JEZTC3I'},

    { reaction_type_id: rand(0..4), customer_id: 789789, product: 'Macbook Pro', product_url: 'https://www.amazon.co.uk/Apple-MacBook-Display-MJLQ2B-Storage/dp/B00Y98VHGK'},
    { reaction_type_id: rand(0..4), customer_id: 789789, product: 'Olympus Tough TG-4 Camera - Red', product_url: 'https://www.amazon.co.uk/Olympus-Tough-TG-4-Camera-Red/dp/B00VWJYJEG'},
    { reaction_type_id: rand(0..4), customer_id: 789789, product: 'Olympus Tough TG-4 Camera - Black', product_url: 'https://www.amazon.co.uk/Olympus-Tough-TG-4-Camera-Black/dp/B00VWJYJPK'},
    { reaction_type_id: rand(0..4), customer_id: 789789, product: 'Sandisk 32GB Ultra SDHC Memory Card', product_url: 'https://www.amazon.co.uk/Sandisk-Ultra-Memory-Olympus-Camera/dp/B00HAJDK7E'},
    { reaction_type_id: rand(0..4), customer_id: 789789, product: 'Amazon Fire TV', product_url: 'https://www.amazon.co.uk/dp/B00UH2O6T2'},
    { reaction_type_id: rand(0..4), customer_id: 789789, product: 'Mighty Mouse', product_url: 'https://www.amazon.co.uk/Apple-MB829Z-A-Magic-Mouse/dp/B002NX0M8C'},
    { reaction_type_id: rand(0..4), customer_id: 789789, product: 'Asus Ultra 4K Monitor', product_url: 'https://www.amazon.co.uk/Asus-PB287Q-Widescreen-Ultra-Monitor/dp/B00JEZTC3I'}

  ])
end

ReactionType.create([
  { name: 'None' },
  { name: 'Like' },
  { name: 'Love' },
  { name: 'Meh' },
  { name: 'Hate' }
])
