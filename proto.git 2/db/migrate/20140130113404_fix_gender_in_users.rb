class FixGenderInUsers < ActiveRecord::Migration
  def up
    rename_column :users, :gendor, :gender
    change_column :users, :gender, :string
  end

  def down
    rename_column :users, :gender, :gendor
    change_column :users, :gendor, :int
  end
end
