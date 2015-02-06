class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :post, index: true
      t.belongs_to :publisher, index: true

      t.timestamps
    end
  end
end
