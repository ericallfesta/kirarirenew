class CreateStamps < ActiveRecord::Migration
  def change
    create_table :stamps do |t|
      t.string :label
      t.string :description
      t.string :slug
      t.string :image
      t.integer :point

      t.timestamps
    end
  end
end
