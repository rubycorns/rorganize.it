class AddTwitterToPeople < ActiveRecord::Migration[5.1]
  def change
  	add_column :people, :twitter, :string
  end
end
