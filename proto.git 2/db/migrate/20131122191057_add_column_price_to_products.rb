class AddColumnPriceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :price, :integer, after: :description
  end
end
