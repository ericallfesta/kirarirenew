class AddGroupIdInTags < ActiveRecord::Migration
  def change
    add_column :tags, :group_id, :integer, after: :id
  end
end
