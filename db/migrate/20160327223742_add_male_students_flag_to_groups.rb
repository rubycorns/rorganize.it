class AddMaleStudentsFlagToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :allow_male_students, :boolean, default: false
  end
end
