class AddDateToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :founded_on, :string
  end
end
