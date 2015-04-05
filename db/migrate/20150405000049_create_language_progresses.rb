class CreateLanguageProgresses < ActiveRecord::Migration
  def change
    create_table :language_progresses do |t|
      t.string :name
      t.integer :level
      t.boolean :learning
      t.integer :points

      t.timestamps null: false
    end
  end
end
