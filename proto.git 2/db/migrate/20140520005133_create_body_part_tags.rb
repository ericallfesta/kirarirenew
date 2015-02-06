class CreateBodyPartTags < ActiveRecord::Migration
  def change
    create_table :body_part_tags do |t|
      t.integer :tag_id
      t.integer :body_part_id

      t.timestamps
    end

    add_index :body_part_tags, [:tag_id, :body_part_id], unique: true
  end
end
