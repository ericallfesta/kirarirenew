class RenameOrderToEvaluations < ActiveRecord::Migration
  def change
    rename_column :evaluations, :order, :priority
  end
end
