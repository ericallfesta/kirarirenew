class SorceryCore < ActiveRecord::Migration
  def self.up
    drop_table :publishers if ActiveRecord::Base.connection.table_exists? :publishers

    create_table :publishers do |t|
      t.string :username,         :null => false
      t.string :display_name
      t.string :email,            :default => nil
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil
      t.text :bio
      t.integer :postable_id
      t.string :postable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :publishers
  end
end