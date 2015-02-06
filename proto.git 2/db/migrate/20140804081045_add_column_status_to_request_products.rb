class AddColumnStatusToRequestProducts < ActiveRecord::Migration
  def change
    add_column :request_products, :status, :string, after: :brand_url, default: 'waiting'
    add_column :request_products, :product_id, :int, after: :status
  end
end
