class AddColumnPriceNoteToProducts < ActiveRecord::Migration
  def change
    add_column :products, :price_note, :string, after: :price
  end
end
