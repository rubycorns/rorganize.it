class AddIndexToMemberships < ActiveRecord::Migration[5.1]
  def change
    add_index :memberships, :group_id
    add_index :memberships, :person_id
    add_index :memberships, [:group_id, :person_id], unique: true
  end
end
