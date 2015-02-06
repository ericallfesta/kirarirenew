class AddColumnSubstanceToColumns < ActiveRecord::Migration
  def change
    add_column :columns, :substance, :string, after: :writer_id
  end
end
