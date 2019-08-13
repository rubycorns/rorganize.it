class RemoveNumberOfMembers < ActiveRecord::Migration[5.1]
  def change
    remove_column :groups, :number_of_members, :integer
  end
end
