class ModifyColumnsToFollows < ActiveRecord::Migration
  def change
    execute "ALTER TABLE follows DROP PRIMARY KEY"
    add_column :follows, :id, :primary_key, first: true
  end
end
