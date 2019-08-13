class AddDateToGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :founded_on, :string
  end
end
