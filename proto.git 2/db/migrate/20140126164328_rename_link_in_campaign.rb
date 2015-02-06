class RenameLinkInCampaign < ActiveRecord::Migration
  def change
    rename_column :campaigns, :link, :url
  end
end
