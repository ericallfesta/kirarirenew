class CreateMakers < ActiveRecord::Migration
  def change
    create_table :makers do |t|
      t.string :name
      t.text :description
      t.string :website
      t.string :hero_image

      t.timestamps
    end
  end
end
