class AddColumnPointToUsers < ActiveRecord::Migration
  def change
    add_column :users, :point, :integer, after: :gender, default: 0
  end
end
