class AddBodyPartIdInTag < ActiveRecord::Migration
  def change
    add_column :tags, :body_part_id, :integer, after: :group_id
  end
end
