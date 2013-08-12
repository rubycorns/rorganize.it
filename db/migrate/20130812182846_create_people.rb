class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :type
      t.belongs_to :group, index: true

      t.timestamps
    end
  end
end
