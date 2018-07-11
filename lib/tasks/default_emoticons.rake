namespace :emoticons do
  task reset: :environment do 

    Emoticon.all.destroy_all
    ActiveRecord::Base.connection.execute('ALTER TABLE emoticons AUTO_INCREMENT = 1')

    Dir.glob("#{Rails.root}/lib/assets/emoticons2/*.png") do |image|
      emoticon = Emoticon.create({
        label: File.basename(image).gsub('_', ': ').gsub('-', ' ').split.map(&:capitalize).join(' ').split('.')[0],
        image: File.new(image, "r"),
        is_default: true
      })
      puts "created emoticon: #{emoticon.label}"
    end


  end

end