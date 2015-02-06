class AddColumnStateToProducts < ActiveRecord::Migration
  def change
    add_column :products, :state, :string, default: 'published', after: :maker_id
  end
end
