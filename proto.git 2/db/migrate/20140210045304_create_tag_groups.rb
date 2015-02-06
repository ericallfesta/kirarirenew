class CreateTagGroups < ActiveRecord::Migration
  def change
    create_table :tag_groups do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
  end
end
