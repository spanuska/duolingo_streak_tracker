class AddColumnToLanguages < ActiveRecord::Migration
  def change
    create_join_table :users, :languages
  end
end
