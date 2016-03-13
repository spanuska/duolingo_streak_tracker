class User < ActiveRecord::Base
  has_many :languages_users
  has_many :languages, through: :languages_users
  def self.get_all_sorted_by_days
    self.order(days: :desc)
  end

end
