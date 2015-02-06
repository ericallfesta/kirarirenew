class CreateReportEfficacies < ActiveRecord::Migration
  def change
    create_table :report_efficacies do |t|
      t.belongs_to :report, index: true
      t.belongs_to :efficacy, index: true

      t.timestamps
    end
  end
end
