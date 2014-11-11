class AddFullAttributeToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :full, :boolean, default: false
  end
end
