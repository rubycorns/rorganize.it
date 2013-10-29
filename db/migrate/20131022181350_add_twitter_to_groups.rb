class AddTwitterToGroups < ActiveRecord::Migration
  def change
  	add_column :groups, :twitter, :string
  end
end
