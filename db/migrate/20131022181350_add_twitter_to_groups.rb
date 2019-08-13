class AddTwitterToGroups < ActiveRecord::Migration[5.1]
  def change
  	add_column :groups, :twitter, :string
  end
end
