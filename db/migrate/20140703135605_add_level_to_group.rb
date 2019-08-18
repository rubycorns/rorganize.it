class AddLevelToGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :level, :string
  end
end
