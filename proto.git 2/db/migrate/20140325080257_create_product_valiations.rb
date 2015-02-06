class CreateProductValiations < ActiveRecord::Migration
  def change
    create_table :product_valiations do |t|
      t.string :name
      t.references :product
      t.string :color_code, limit: 6
      t.string :color_name
      t.string :size_name
      t.integer :size_value
      t.string :size_unit
      t.integer :price
      t.string :image

      t.timestamps
    end
  end
end
