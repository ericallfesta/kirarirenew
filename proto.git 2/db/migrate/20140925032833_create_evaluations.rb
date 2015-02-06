class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.belongs_to :category, index: true
      t.string :name
      t.integer :order

      t.timestamps
    end
  end
end
