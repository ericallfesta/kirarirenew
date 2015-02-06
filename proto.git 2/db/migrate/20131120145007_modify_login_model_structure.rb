class ModifyLoginModelStructure < ActiveRecord::Migration
  def change
    # Add columns to user from publisher.
    add_column :users, :username,         :string,  null: false, after: :id
    add_column :users, :display_name,     :string,  after: :username
    add_column :users, :email,            :string,  default: nil, after: :display_name
    add_column :users, :crypted_password, :string,  default: nil, after: :email
    add_column :users, :salt,             :string,  default: nil, after: :crypted_password
    add_column :users, :bio,              :text,    after: :salt
    add_column :users, :image,            :string,  after: :bio
    add_column :users, :role,             :string,  after: :column_writer
    add_column :users, :brand_id,         :integer, after: :column_writer, index: true

    # Add brand base information columns. 
    add_column :brands, :name,        :string, after: :id
    add_column :brands, :description, :text,   after: :name

    # rename publisher_id to writer_id
    rename_column :writings, :publisher_id, :writer_id
    rename_column :comments, :publisher_id, :user_id

    # Remove unnecessary table.
    drop_table :publishers
  end
end
