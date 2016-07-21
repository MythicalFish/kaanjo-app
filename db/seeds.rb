# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'seeding data'

Admin.create({ email:'jake@freshsector.com', password:'test1234', first_name: 'Jake',        last_name: 'Broughton'  })

Webmaster.create([
  { email:'webmaster1@site1.com', password:'test1234',       website: 'site1.com',             first_name: 'Webmaster',   last_name: 'One' },
  { email:'jake@demo-shop.vertaxe.com', password:'test1234', website: 'demo-shop.vertaxe.com', first_name: 'Jake',        last_name: 'Broughton' },
  { email:'jake@localhost:8000', password:'test1234',        website: 'localhost:8000',        first_name: 'Jake',        last_name: 'Broughton' },
  { email:'webmaster4@site4.com', password:'test1234',       website: 'site4.com',             first_name: 'Webmaster',   last_name: 'Four' },
  { email:'webmaster5@site5.com', password:'test1234',       website: 'site5.com',             first_name: 'Webmaster',   last_name: 'Five' },
  { email:'webmaster6@site6.com', password:'test1234',       website: 'site6.com',             first_name: 'Webmaster',   last_name: 'Six' },
  { email:'webmaster7@site7.com', password:'test1234',       website: 'site7.com',             first_name: 'Webmaster',   last_name: 'Seven' },
  { email:'webmaster8@site8.com', password:'test1234',       website: 'site8.com',             first_name: 'Webmaster',   last_name: 'Eight' },
  { email:'webmaster9@site9.com', password:'test1234',       website: 'site9.com',             first_name: 'Webmaster',   last_name: 'Nine' },
  { email:'webmaster10@site10.com', password:'test1234',     website: 'site10.com',            first_name: 'Webmaster',   last_name: 'Ten' },
  { email:'webmaster11@site11.com', password:'test1234',     website: 'site11.com',            first_name: 'Webmaster',   last_name: 'Eleven' },
  { email:'webmaster12@site12.com', password:'test1234',     website: 'site12.com',            first_name: 'Webmaster',   last_name: 'Twelve' },
  { email:'webmaster13@site13.com', password:'test1234',     website: 'site13.com',            first_name: 'Webmaster',   last_name: 'Thirteen' },
  { email:'webmaster14@site14.com', password:'test1234',     website: 'site14.com',            first_name: 'Webmaster',   last_name: 'Fourteen' },
  { email:'webmaster15@site15.com', password:'test1234',     website: 'site15.com',            first_name: 'Webmaster',   last_name: 'Fifteen' },
  { email:'webmaster16@site16.com', password:'test1234',     website: 'site16.com',            first_name: 'Webmaster',   last_name: 'Sixteen' },
  { email:'webmaster17@site17.com', password:'test1234',     website: 'site17.com',            first_name: 'Webmaster',   last_name: 'Seventeen' },
  { email:'webmaster18@site18.com', password:'test1234',     website: 'site18.com',            first_name: 'Webmaster',   last_name: 'Eighteen' },
  { email:'webmaster19@site19.com', password:'test1234',     website: 'site19.com',            first_name: 'Webmaster',   last_name: 'Nineteen' },
  { email:'webmaster20@site20.com', password:'test1234',     website: 'site20.com',            first_name: 'Webmaster',   last_name: 'Twenty' }
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

    rand(51..400).times do
      t = Time.now - rand(0..172800)
      p.impressions.create(customer_id:customer_ids.sample,webmaster_id:w.id,created_at:t)
    end

    rand(2..20).times do
      t = Time.now - rand(0..172800)
      p.reactions.create(reaction_type_id: rand(1..4),customer_id:customer_ids.sample,webmaster_id:w.id,created_at:t)
    end

  end
end

ReactionType.create([
  { name: 'Like' },
  { name: 'Love' },
  { name: 'Meh' },
  { name: 'Hate' }
])
