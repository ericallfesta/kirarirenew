class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :body
      t.integer :noticeable_id
      t.string :noticeable_type

      t.timestamps
    end
  end
end
