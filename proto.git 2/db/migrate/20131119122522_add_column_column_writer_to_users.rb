class AddColumnColumnWriterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :column_writer, :boolean, default: false, after: :id
  end
end
