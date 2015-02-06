class AddColumnCommentedAtToWritings < ActiveRecord::Migration
  def change
    add_column :writings, :commented_at, :datetime
  end
end
