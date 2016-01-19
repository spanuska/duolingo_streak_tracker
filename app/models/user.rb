class User < ActiveRecord::Base

	require 'open-uri'
	# name, site_streak, language, language_level

	validates :name, uniqueness: true
	has_many :language_progresses

	scope :platinum, -> { where('streak >= 730') }
	scope :gold, -> { where(streak: 500..729) }
	scope :silver, -> { where(streak: 400..499) }
	scope :bronze, -> { where(streak: 365..399) }
	scope :soon_to_be, -> { where(streak: 300..364) }

	attr_accessor :api_hash, :languages_where_learning_is_true

#-- CLASS METHODS
	def self.populate(duo_username)
		@api_hash = self.api_call(duo_username).select do |k, v|
			k == "username" || k == "site_streak" || k == "languages"
		end
		current = self.find_or_create_by(name: @api_hash["username"])
		current.update(streak: @api_hash["site_streak"])
		# @languages_where_learning_is_true = current.find_languages_where_learning_is_true
		# current.update_language_progresses
	end
	
	def self.api_call(duo_username)
		url = "https://api.duolingo.com/users/#{duo_username}"
		JSON.load(open(url))
	end

#-- INSTANCE METHODS
	def populate_from_refresh
		self.update(streak: @api_hash["site_streak"])
		self.create_language_progresses
	end

	# def find_languages_where_learning_is_true
	# 	@api_hash["languages"].keep_if do |language_hash| 
	# 		language_hash["learning"] == true
	# 	end
	# end

	# def update_language_progresses
	# 	@languages_where_learning_is_true.collect do |language| 
	# 		lang_prog = LanguageProgress.find_or_create_by(name: language["language_string"], user_id: self.id)
	# 		lang_prog.update(points: language["points"], level: language["level"])
	# 	end
	# end

	# def create_language_progresses
	# 	languages_where_learning_is_true.collect do |language|
	# 		langprog = LanguageProgress.find_or_create_by(user_id: self.id, name: language["language_string"])
	# 		langprog.update(level: language["level"], points: language["points"])
	# 	end
	# end

end
