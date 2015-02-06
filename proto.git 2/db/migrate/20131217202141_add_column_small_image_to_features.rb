class AddColumnSmallImageToFeatures < ActiveRecord::Migration
  def change
    add_column :features, :small_image, :string, after: :hero_image
  end
end
