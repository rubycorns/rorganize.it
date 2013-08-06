class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|

      t.string :first_name
      t.string :last_name
      t.string :email
      t.belongs_to :group

      t.timestamps
    end
  end
end
