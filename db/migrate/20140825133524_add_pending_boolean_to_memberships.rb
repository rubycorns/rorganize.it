class AddPendingBooleanToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :pending, :boolean, default: false
  end
end
