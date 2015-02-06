class CreatePopularKeywords < ActiveRecord::Migration
  def change
    create_table :popular_keywords do |t|
      t.string :word
      t.integer :priority
      t.boolean :deleted

      t.timestamps
    end
  end
end
