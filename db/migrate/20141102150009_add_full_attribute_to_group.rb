class AddFullAttributeToGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :full, :boolean, default: false
  end
end
