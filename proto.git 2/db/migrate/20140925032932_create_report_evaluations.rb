class CreateReportEvaluations < ActiveRecord::Migration
  def change
    create_table :report_evaluations do |t|
      t.belongs_to :report, index: true
      t.belongs_to :evaluation, index: true
      t.integer :star

      t.timestamps
    end
  end
end
