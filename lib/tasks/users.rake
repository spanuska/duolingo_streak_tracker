require 'open-uri'


namespace :users do
  desc "Scrapes unofficial hall of fame thread to get usernames"
  task import_from_thread: :environment do
    url = "https://www.duolingo.com/comments/2933824"
    json = JSON.load(open(url))
    message = json["marked_down_message"]
    page = Nokogiri::HTML(message)
    links = page.css('a')
    names = links.map do |link| link.text end
                 .select do |link_text| !link_text.match(/\s/) end

    names.each do |name|
      User.create(username: name)
    end

  end

  desc "Calls unofficial Duolingo api to get up-to-date user data"
  task refresh_from_api: :environment do
    User.find_each(batch_size: 10) do |user|
      begin
        url = "https://api.duolingo.com/users/" + user.username
        json = JSON.load(open(url))
        streak_days = json["site_streak"]
        languages = json["languages"].select { |l| l["learning"] }
        languages.each do |l|
          language_instance = Language.find_or_create_by(name: l["language_string"])
          user.languages << language_instance unless user.languages.include? language_instance
        end

        user.days = streak_days
        user.save
      rescue
        next
      end

      puts 'refreshed ' + user.username + ' from the api'
    end
  end
end

