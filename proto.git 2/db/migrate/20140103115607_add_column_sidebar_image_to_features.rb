class AddColumnSidebarImageToFeatures < ActiveRecord::Migration
  def change
    add_column :features, :sidebar_image, :string, after: :hero_image
  end
end
