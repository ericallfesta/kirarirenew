class AddSourceUrlInProducts < ActiveRecord::Migration
  def change
    add_column :products, :source_url, :string, limit: 511
  end
end
