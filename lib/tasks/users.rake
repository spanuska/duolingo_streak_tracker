require 'open-uri'

namespace :users do
  task import_from_thread: :environment do

    url = "https://www.duolingo.com/comments/7429832"
    json = JSON.load(open(url))
    message = json["marked_down_message"]
    page = Nokogiri::HTML(message)
    links = page.css('a')
    names = links.map do |link| link.text end
                 .select do |link_text| !link_text.match(/\s/) end

    names.each do |name|
      User.create(name: name)
    end

  end

  task refresh_from_api: :environment do
    User.find_each(batch_size: 10) do |user|
    end


  end
end
