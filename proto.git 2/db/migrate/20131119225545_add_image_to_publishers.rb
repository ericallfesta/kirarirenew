class AddImageToPublishers < ActiveRecord::Migration
  def change
    add_column :publishers, :image, :string
  end
end
