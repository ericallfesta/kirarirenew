class AddStatusInSerials < ActiveRecord::Migration
  def change
    add_column :serials, :status, :string, after: :image
  end
end
