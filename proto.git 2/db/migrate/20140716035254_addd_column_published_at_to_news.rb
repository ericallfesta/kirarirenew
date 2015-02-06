class AdddColumnPublishedAtToNews < ActiveRecord::Migration
  def change
    add_column :news, :published_at, :datetime
  end
end
