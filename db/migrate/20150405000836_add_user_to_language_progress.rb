class AddUserToLanguageProgress < ActiveRecord::Migration
  def change
  	add_column :language_progresses, :user_id, :integer
  end
end
