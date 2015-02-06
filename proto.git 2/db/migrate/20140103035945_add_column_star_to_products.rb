class AddColumnStarToProducts < ActiveRecord::Migration
  def change
    add_column :products, :star, :string, after: :slug
  end
end
