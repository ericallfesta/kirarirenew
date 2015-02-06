class AddColumnToWebsiteProductValiation < ActiveRecord::Migration
  def change
    add_column :product_valiations, :website, :string, after: :ingredient
  end
end
