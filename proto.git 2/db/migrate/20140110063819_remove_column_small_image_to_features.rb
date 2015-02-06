class RemoveColumnSmallImageToFeatures < ActiveRecord::Migration
  def change
    remove_column :features, :small_image
  end
end
