class CreateMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :memberships do |t|
      t.integer :group_id
      t.integer :person_id

      t.timestamps
    end
  end
end
