class RenamePostIdToComments < ActiveRecord::Migration
  def change
    rename_column :comments, :post_id, :writing_id
  end
end
