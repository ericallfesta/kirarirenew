class DropCategories < ActiveRecord::Migration
  def change
    drop_table :categories
    remove_column :products, :category_id
  end
end
