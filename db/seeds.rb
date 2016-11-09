# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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