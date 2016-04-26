class AddMaleStudentsFlagToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :allow_male_students, :boolean, default: false
  end
end
