class AddPictureToGroups < ActiveRecord::Migration[5.1]
  def change
  	add_column :groups, :picture, :string
  end
end
