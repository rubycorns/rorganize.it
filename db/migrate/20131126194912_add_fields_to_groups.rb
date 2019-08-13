class AddFieldsToGroups < ActiveRecord::Migration[5.1]
  def change
  	add_column :groups, :contact, :text
  	add_column :groups, :activities, :text
  end

end
