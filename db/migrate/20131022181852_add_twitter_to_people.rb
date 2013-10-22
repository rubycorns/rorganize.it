class AddTwitterToPeople < ActiveRecord::Migration
  def change
  	add_column :people, :twitter, :string
  end
end
