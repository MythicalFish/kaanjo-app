namespace :default_emoticons do
  task reset: :environment do 

    Emoticon.all.delete_all
    ActiveRecord::Base.connection.execute('ALTER TABLE emoticons AUTO_INCREMENT = 1')

    Dir.glob("#{Rails.root}/lib/assets/emoticons/*.svg") do |image|
      emoticon = Emoticon.create({
        label: File.basename(image),
        image: File.new(image, "r"),
        is_default: true
      })
      puts "created emoticon: #{emoticon.label}"
    end

    labels = ['Like','Love','Happy','Meh','Nice Gift']

    Emoticon.all.limit(5).each_with_index do |e,i|
      e.label = labels[i]
      e.save
    end

  end

end