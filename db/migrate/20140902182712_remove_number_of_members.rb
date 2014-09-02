class RemoveNumberOfMembers < ActiveRecord::Migration
  def change
    remove_column :groups, :number_of_members, :integer
  end
end
