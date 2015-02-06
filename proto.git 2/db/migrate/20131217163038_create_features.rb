class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :title
      t.text :description
      t.string :hero_image
      t.string :link
      t.integer :priority
      t.boolean :active

      t.timestamps
    end
  end
end
