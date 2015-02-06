class AddColumnDisplayKanaToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :display_kana, :boolean, after: :kana, default: false
  end
end
