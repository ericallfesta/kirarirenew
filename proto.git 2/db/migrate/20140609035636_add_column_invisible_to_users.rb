class AddColumnInvisibleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invisible, :boolean, default: false, after: :column_writer
  end
end
