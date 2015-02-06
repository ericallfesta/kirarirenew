class AddColumnImageToColumns < ActiveRecord::Migration
  def change
    add_column :columns, :image, :string, after: :body
  end
end
