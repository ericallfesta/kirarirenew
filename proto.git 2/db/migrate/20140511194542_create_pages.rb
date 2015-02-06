class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :body
      t.string :slug
      t.integer :priority

      t.timestamps
    end
  end
end
