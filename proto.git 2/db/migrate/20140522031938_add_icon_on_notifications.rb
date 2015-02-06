class AddIconOnNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :icon, :string, after: :user_id
  end
end
