class AddPictureToPerson < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :picture, :string
  end
end
