class LanguageProgress < ActiveRecord::Base

	belongs_to :user
	validates_uniqueness_of :user_id, scope: :name

end
