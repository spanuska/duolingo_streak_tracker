class Language < ActiveRecord::Base
  has_many :languages_users
  has_many :users, through: :languages_users
end
