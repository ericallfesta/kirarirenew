class AddColumnVariationToProductImages < ActiveRecord::Migration
  def change
    add_reference :product_images, :variation, index: true, after: :product_id
    add_column :product_images, :primary, :boolean, after: :src, default: false
  end
end
