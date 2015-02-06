class AddColumnGendorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gendor, :integer, after: :birthday
  end
end
