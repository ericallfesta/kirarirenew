class CreateColumns < ActiveRecord::Migration
  def change
    create_table :columns do |t|
      t.string :title
      t.text :body
      t.belongs_to :serial, index: true
      t.integer :serial_num
      t.belongs_to :writer, index: true

      t.timestamps
    end
  end
end
