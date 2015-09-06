class AddInactiveAttributeToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :inactive, :boolean, default: false
  end
end
