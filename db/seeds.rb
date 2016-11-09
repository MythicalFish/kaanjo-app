# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Campaign.all.delete_all
Impression.all.delete_all
Reaction.all.delete_all

PRODUCTS = [
  { name: 'Macbook Pro', url: 'https://www.amazon.co.uk/Apple-MacBook-Display-MJLQ2B-Storage/dp/B00Y98VHGK'},
  { name: 'Olympus Tough TG-4 Camera - Red', url: 'https://www.amazon.co.uk/Olympus-Tough-TG-4-Camera-Red/dp/B00VWJYJEG'},
  { name: 'Olympus Tough TG-4 Camera - Black', url: 'https://www.amazon.co.uk/Olympus-Tough-TG-4-Camera-Black/dp/B00VWJYJPK'},
  { name: 'Sandisk 32GB Ultra SDHC Memory Card', url: 'https://www.amazon.co.uk/Sandisk-Ultra-Memory-Olympus-Camera/dp/B00HAJDK7E'},
  { name: 'Amazon Fire TV', url: 'https://www.amazon.co.uk/dp/B00UH2O6T2'},
  { name: 'Mighty Mouse', url: 'https://www.amazon.co.uk/Apple-MB829Z-A-Magic-Mouse/dp/B002NX0M8C'},
  { name: 'Asus Ultra 4K Monitor', url: 'https://www.amazon.co.uk/Asus-PB287Q-Widescreen-Ultra-Monitor/dp/B00JEZTC3I'}
]

w = Webmaster.first

puts "Webmaster: #{w.name}"
puts "Seeding #{w.campaigns.length} campaigns"
puts ""
puts ""

w.campaigns.try(:each) do | c|

  puts "Seeding campaign #{c.name}"
  puts ""

  puts "Creating products for campaign"
  c.products.create(PRODUCTS)

  puts "Creating customers for campaign"
  100.times { c.customers.create }

  puts "Creating impressions for above customers (with randomly associated products from above)"

  product_ids = c.products.ids

  c.customers.each do |customer|
    impressions = []
    rand(1000).times do
      impressions << { product_id: product_ids.sample }
    end
    customer.impressions.create(impressions)
  end

  puts "Creating reactions based on impressions"

  c.customers.impressions.each do |impression|
    next unless rand(10) < 2
    impression.reaction.create
  end

end