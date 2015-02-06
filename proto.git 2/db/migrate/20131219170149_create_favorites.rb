class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.belongs_to :user, index: true
      t.string :favorable_type
      t.integer :favorable_id

      t.timestamps
    end
  end
end
