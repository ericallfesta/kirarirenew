class AddColumnSolvedToWritings < ActiveRecord::Migration
  def change
    add_column :writings, :solved, :boolean, after: :star
  end
end
