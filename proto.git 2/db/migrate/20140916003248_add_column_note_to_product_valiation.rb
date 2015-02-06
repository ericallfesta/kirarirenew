class AddColumnNoteToProductValiation < ActiveRecord::Migration
  def change
    add_column :product_valiations, :ingredient, :text, after: :image
    add_column :product_valiations, :note, :text, after: :image
  end
end
