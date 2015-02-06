class CreatePhotographs < ActiveRecord::Migration
  def change
    create_table :photographs do |t|
      t.string :name
      t.belongs_to :writing, index: true

      t.timestamps
    end
  end
end
