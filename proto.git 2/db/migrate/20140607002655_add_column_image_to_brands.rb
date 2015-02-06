class AddColumnImageToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :image, :string, after: :hero_image
  end
end
