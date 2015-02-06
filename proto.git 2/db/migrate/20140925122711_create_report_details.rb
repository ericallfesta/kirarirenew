class CreateReportDetails < ActiveRecord::Migration
  def change
    create_table :report_details do |t|
      t.belongs_to :report, index: true
      t.string :use_times
      t.string :use_type
      t.string :bought_place

      t.timestamps
    end
  end
end
