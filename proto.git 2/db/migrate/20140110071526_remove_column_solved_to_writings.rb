class RemoveColumnSolvedToWritings < ActiveRecord::Migration
  def change
    remove_column :writings, :solved
  end
end
