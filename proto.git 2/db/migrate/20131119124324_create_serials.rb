class CreateSerials < ActiveRecord::Migration
  def change
    create_table :serials do |t|
      t.string :title
      t.text :description
      t.belongs_to :writer, index: true

      t.timestamps
    end
  end
end
