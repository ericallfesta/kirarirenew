class AddColumnIngredientToProducts < ActiveRecord::Migration
  def change
    add_column :products, :ingredient, :text, after: :description
  end
end
