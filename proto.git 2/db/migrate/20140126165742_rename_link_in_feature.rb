class RenameLinkInFeature < ActiveRecord::Migration
  def change
    rename_column :features, :link, :url
  end
end
