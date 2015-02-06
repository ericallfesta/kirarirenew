class AddColumnImageToProducts < ActiveRecord::Migration
  def change
    add_column :products, :image, :string, after: :description
  end
end
