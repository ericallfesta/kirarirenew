class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.belongs_to :writing, index: true
      t.string :src

      t.timestamps
    end
  end
end
