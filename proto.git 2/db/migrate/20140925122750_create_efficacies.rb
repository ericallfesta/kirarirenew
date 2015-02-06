class CreateEfficacies < ActiveRecord::Migration
  def change
    create_table :efficacies do |t|
      t.belongs_to :category, index: true
      t.string :name

      t.timestamps
    end
  end
end
