class AddGroupCodeInBodyPart < ActiveRecord::Migration
  def change
    add_column :body_parts, :group_code, :string, after: :slug
  end
end
