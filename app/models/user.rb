class User < ActiveRecord::Base
  has_many :languages_users
  has_many :languages, through: :languages_users
  scope :platinum, -> {where("days > 719")} 
  scope :gold, -> {where("days > 364 and days <= 719")} 
  scope :silver, -> {where("days > 199 and days <= 364")} 
  scope :bronze, -> {where("days > 99 and days <= 199")} 
  def self.get_all_sorted_by_days
    self.order(days: :desc)
  end

end
