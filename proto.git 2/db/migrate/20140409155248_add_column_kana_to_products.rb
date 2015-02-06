class AddColumnKanaToProducts < ActiveRecord::Migration
  def change
    add_column :products, :kana, :string, after: :name
  end
end
