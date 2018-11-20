class CreateInvites < ActiveRecord::Migration[5.0]
  def change
    create_table :invites do |t|
      t.integer :group_id, null: false
      t.integer :person_id, null: false
      t.timestamps
    end
  end
end
