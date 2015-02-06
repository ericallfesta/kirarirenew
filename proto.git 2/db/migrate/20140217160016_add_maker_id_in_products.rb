class AddMakerIdInProducts < ActiveRecord::Migration
  def change
    add_column :products, :maker_id, :integer, after: :brand_id
  end
end
