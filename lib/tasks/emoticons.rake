namespace :emoticons do

  task reset: :environment do 

    Emoticon.all.delete_all
    ActiveRecord::Base.connection.execute('ALTER TABLE emoticons AUTO_INCREMENT = 1')

    Dir.glob("#{Rails.root}/lib/assets/emoticons/*.svg") do |image|
      emoticon = Emoticon.create({
        default_label: File.basename(image),
        image: File.new(image, "r")
      })
      puts "created emoticon: #{emoticon.default_label}"
    end

  end

end