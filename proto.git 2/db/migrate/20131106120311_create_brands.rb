class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :website
      t.string :hero_image

      t.timestamps
    end
  end
end
