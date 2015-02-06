class CreateFollows < ActiveRecord::Migration
  def up
    create_table :follows, id: false do |t|
      t.integer :user_id
      t.string :followable_type
      t.integer :followable_id

      t.timestamps
    end
    execute "ALTER TABLE follows ADD PRIMARY KEY (user_id, followable_type, followable_id)"
  end

  def down
    drop_table :follows
  end
end
