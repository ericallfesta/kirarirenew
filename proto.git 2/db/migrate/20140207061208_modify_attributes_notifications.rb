class ModifyAttributesNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :url, :string, after: :body
    add_column :notifications, :user_id, :integer, after: :id
    add_column :notifications, :status, :string, after: :url
    remove_column :notifications, :title, :string
    add_index :notifications, :user_id
  end
end
