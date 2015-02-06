class AddColumnWatchedToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :watched, :boolean, after: :ua, default: false
  end
end
