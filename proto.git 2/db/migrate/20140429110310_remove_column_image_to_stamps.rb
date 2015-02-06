class RemoveColumnImageToStamps < ActiveRecord::Migration
  def change
    remove_column :stamps, :image
  end
end
