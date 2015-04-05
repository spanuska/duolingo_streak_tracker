class User < ActiveRecord::Base

	require 'open-uri'
	# name, site_streak, language, language_level

	validates :name, uniqueness: true
	has_many :language_progresses

	attr_accessor :api_hash

	def populate_from_refresh(api_hash)
		self.update(streak: api_hash["site_streak"])
		self.create_language_progresses(api_hash)
	end

	def self.populate(duo_username)
		api_hash = self.api_call(duo_username)
		binding.pry
		current = self.find_or_create_by(name: api_hash["username"])
		current.update(streak: api_hash["site_streak"])
		current.create_language_progresses(api_hash)
	end
	
	def self.api_call(duo_username)
		url = "https://api.duolingo.com/users/#{duo_username}"
		JSON.load(open(url))
	end

	def create_language_progresses(api_hash)
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
