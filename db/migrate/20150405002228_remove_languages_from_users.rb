class RemoveLanguagesFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :languages, :string
  end
end
