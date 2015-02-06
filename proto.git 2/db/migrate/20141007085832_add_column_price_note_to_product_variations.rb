class AddColumnPriceNoteToProductVariations < ActiveRecord::Migration
  def change
    add_column :product_variations, :price_note, :string, after: :price
  end
end
