class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.text :body
      t.belongs_to :writer, index: true
      t.string :status
      t.string :image

      t.timestamps
    end
  end
end
