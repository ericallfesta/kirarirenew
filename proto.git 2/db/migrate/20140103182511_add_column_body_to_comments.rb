class AddColumnBodyToComments < ActiveRecord::Migration
  def change
    add_column :comments, :body, :text, after: :user_id
  end
end
