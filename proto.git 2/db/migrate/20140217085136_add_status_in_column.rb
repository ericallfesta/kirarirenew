class AddStatusInColumn < ActiveRecord::Migration
  def change
    add_column :columns, :status, :string, after: :writer_id
  end
end
