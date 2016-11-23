namespace :emoticons do
  task add: :environment do 

    Dir.glob("#{Rails.root}/lib/assets/emoticons2/*.png") do |image|
      emoticon = Emoticon.create({
        label: File.basename(image),
        image: File.new(image, "r"),
        is_default: true
      })
      puts "created emoticon: #{emoticon.label}"
    end


  end

end