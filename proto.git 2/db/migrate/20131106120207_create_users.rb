class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.date :birthday
      t.string :range_policy

      t.timestamps
    end
  end
end
