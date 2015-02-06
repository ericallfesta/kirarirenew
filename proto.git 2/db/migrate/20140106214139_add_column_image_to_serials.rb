class AddColumnImageToSerials < ActiveRecord::Migration
  def change
    add_column :serials, :image, :string, after: :description
  end
end
