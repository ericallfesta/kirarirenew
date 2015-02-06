class RenameVariation < ActiveRecord::Migration
  def change
    rename_table :product_valiations, :product_variations
    rename_table :valiation_images, :variation_images
    rename_column :variation_images, :product_valiation_id, :product_variation_id
  end
end
