class AddInactiveAttributeToGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :inactive, :boolean, default: false
  end
end
