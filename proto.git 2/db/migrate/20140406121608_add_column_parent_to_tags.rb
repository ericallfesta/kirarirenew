class AddColumnParentToTags < ActiveRecord::Migration
  def change
    add_reference :tags, :parent, index: true, after: :id
  end
end
