class AddColumnKanaToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :kana, :string, after: :name
  end
end
