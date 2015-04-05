class User < ActiveRecord::Base

	require 'open-uri'
	# name, site_streak, language, language_level

	has_many :language_progresses

	attr_accessor :api_hash

	def populate(duo_username)
		api_call(duo_username)
		binding.pry
		self.find_or_create_by(name: api_hash["username"])
		self.update(streak: api_hash["site_streak"])
		create_language_progresses
	end
	
	def api_call(duo_username)
		url = "https://api.duolingo.com/users/#{duo_username}"
		self.api_hash = JSON.load(open(url))
	end

	def create_language_progresses
		api_hash["languages"].collect do |language|
			if language["learning"]
				self.language_progresses.create(
						learning: language["learning"],
						name: language["language_string"],
						level: language["level"],
						points: language["points"]
					)
			end
		end
	end

end
