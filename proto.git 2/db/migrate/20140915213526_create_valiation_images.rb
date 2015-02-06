class CreateValiationImages < ActiveRecord::Migration
  def change
    create_table :valiation_images do |t|
      t.belongs_to :product_valiation, index: true
      t.string :src

      t.timestamps
    end
  end
end
