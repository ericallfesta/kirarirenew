class DropPhotographs < ActiveRecord::Migration
  def change
    drop_table :photographs
  end
end
