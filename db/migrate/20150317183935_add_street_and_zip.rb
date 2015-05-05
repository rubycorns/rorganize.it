class AddStreetAndZip < ActiveRecord::Migration
  def change
    add_column :groups, :zip, :string
    add_column :groups, :street, :string
  end
end
