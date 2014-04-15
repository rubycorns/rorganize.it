class AddIndexToMemberships < ActiveRecord::Migration
  def change
    add_index :memberships, :group_id
    add_index :memberships, :person_id
    add_index :memberships, [:group_id, :person_id], unique: true
  end
end
