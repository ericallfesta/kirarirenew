class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :slug
      t.belongs_to :category, index: true
      t.belongs_to :brand, index: true

      t.timestamps
    end
  end
end
