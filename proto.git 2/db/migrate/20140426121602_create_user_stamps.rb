class CreateUserStamps < ActiveRecord::Migration
  def change
    create_table :user_stamps do |t|
      t.belongs_to :user, index: true
      t.belongs_to :stamp, index: true

      t.timestamps
    end
  end
end
