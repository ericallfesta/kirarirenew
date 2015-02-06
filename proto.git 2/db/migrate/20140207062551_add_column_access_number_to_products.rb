class AddColumnAccessNumberToProducts < ActiveRecord::Migration
  def change
    add_column :products, :access_number, :integer, after: :brand_id, default: 0
  end
end

