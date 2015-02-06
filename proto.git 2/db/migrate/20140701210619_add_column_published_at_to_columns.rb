class AddColumnPublishedAtToColumns < ActiveRecord::Migration
  def change
    add_column :columns, :published_at, :datetime
  end
end
