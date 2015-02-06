class CreateWritings < ActiveRecord::Migration
  def change
    create_table :writings do |t|
      t.string :title
      t.text :body
      t.integer :star
      t.string :type
      t.belongs_to :product, index: true
      t.belongs_to :publisher, index: true
      t.string :range, default: 'public'

      t.timestamps
    end
  end
end
