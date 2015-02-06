class AddColumnCanonicalUrlToColumns < ActiveRecord::Migration
  def change
    add_column :columns, :canonical_url, :string, after: :substance
  end
end
