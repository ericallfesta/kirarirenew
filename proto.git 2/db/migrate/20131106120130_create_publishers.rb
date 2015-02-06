class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.string :username
      t.string :display_name
      t.string :icon_url
      t.string :email
      t.text :bio
      t.integer :postable_id
      t.string :postable_type

      t.timestamps
    end
  end
end
