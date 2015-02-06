class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.string :link
      t.boolean :active

      t.timestamps
    end
  end
end
