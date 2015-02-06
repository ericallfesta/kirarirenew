class AddColumnPublishedAtToSerials < ActiveRecord::Migration
  def change
    add_column :serials, :published_at, :datetime
  end
end
