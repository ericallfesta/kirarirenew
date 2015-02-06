class RemoveColumnsByRefactoring < ActiveRecord::Migration
  def change
    remove_column :tags, :official
    remove_column :product_variations, :color_code
    remove_column :product_variations, :color_name
    remove_column :product_variations, :size_name
    remove_column :product_variations, :size_value
    remove_column :product_variations, :size_unit
    drop_table :notices
  end
end
