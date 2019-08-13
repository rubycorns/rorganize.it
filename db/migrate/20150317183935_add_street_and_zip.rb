class AddStreetAndZip < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :zip, :string
    add_column :groups, :street, :string
  end
end
