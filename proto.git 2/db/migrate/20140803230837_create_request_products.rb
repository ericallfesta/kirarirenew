class CreateRequestProducts < ActiveRecord::Migration
  def change
    create_table :request_products do |t|
      t.string :name
      t.string :brand
      t.belongs_to :user, index: true
      t.string :product_url
      t.string :brand_url

      t.timestamps
    end
  end
end
