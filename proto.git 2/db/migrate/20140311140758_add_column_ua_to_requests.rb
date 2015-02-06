class AddColumnUaToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :ua, :string, after: :url
  end
end
