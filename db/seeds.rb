# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create({ email:'jake@freshsector.com', password:'test1234' })

Webmaster.create([
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

    customer_ids = [123,456,789,111,222,333]

    rand(50..1000).times do
      p.impressions.create(customer_id:customer_ids.sample)
    end

    rand(5..50).times do
      p.reactions.create(reaction_type_id: rand(1..4),customer_id:customer_ids.sample)
    end

  end
end

ReactionType.create([
  { name: 'Like' },
  { name: 'Love' },
  { name: 'Meh' },
  { name: 'Hate' }
])
