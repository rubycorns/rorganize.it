class AddFieldsToGroups < ActiveRecord::Migration
  def change
  	add_column :groups, :contact, :text
  	add_column :groups, :activities, :text
  end

end
