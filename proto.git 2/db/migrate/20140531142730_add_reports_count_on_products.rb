class AddReportsCountOnProducts < ActiveRecord::Migration
  def up
    add_column :products, :reports_count, :integer, default: 0

    Product.reset_column_information
    Product.all.each do |product|
      product.reports_count = product.reports.count
      product.save
    end
  end

  def down
    remove_column :products, :reports_count
  end
end
