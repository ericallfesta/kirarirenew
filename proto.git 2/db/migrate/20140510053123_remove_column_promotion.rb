class RemoveColumnPromotion < ActiveRecord::Migration
  def change
    remove_column :brands, :promotion if Brand.column_names.include?(:promotion)
    remove_column :makers, :promotion if Maker.column_names.include?(:promotion)
    remove_column :products, :promotion if Product.column_names.include?(:promotion)
  end
end
