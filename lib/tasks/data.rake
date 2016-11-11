namespace :data do
  task seed: :environment do

    Impression.all.delete_all
    Reaction.all.delete_all
    Product.all.delete_all

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


    raise "At least 1 webmaster needed" unless w
    raise "At least 1 campaign needed" unless w.campaigns.any?

    puts ""
    puts ""
    puts "Webmaster: #{w.name}"
    puts ""
    puts ""

    c = w.campaigns.first

    puts "Seeding Campaign: #{c.name}"
    puts ""

    puts "Creating products for campaign"
    c.products.create(PRODUCTS)

    puts "Creating customers for campaign"
    100.times { c.customers.create }

    puts "Creating impressions for above customers (with randomly associated products from above)"

    product_ids = c.products.ids
    start_date = Date.today - 7
    dates = (start_date..Date.today).to_a

    c.customers.each do |customer|
      impressions = []
      rand(100).times do
        impressions << { product_id: product_ids.sample, created_at: dates.sample }
      end
      customer.impressions.create(impressions)
    end

    puts "Creating reactions based on impressions"

    scenario_ids = c.scenarios.ids

    c.impressions.each do |impression|
      next unless rand(100) < rand((2..5))
      Reaction.create({
        impression_id: impression.id,
        scenario_id: scenario_ids.sample,
        created_at: (impression.created_at + 10)
      })
    end


  end
end 