class UsersController < ApplicationController

	def index
		# binding.pry
		
		@platinums = User.platinum
		@golds = User.gold
		@silvers = User.silver
		@bronzes = User.bronze
		@soons = User.soon_to_be
	end

end
