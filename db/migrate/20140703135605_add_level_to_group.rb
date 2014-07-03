class AddLevelToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :level, :string
  end
end
