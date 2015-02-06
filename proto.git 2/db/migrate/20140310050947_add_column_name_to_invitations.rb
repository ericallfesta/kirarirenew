class AddColumnNameToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :name, :string, after: :id, default: ''
  end
end
