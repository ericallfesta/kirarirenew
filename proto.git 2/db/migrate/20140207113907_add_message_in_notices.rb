class AddMessageInNotices < ActiveRecord::Migration
  def change
    add_column :notices, :message, :string, after: :body
  end
end
