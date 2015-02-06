class AddColumnUrlToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :url, :string, after: :body
  end
end
