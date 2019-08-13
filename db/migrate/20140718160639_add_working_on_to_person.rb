class AddWorkingOnToPerson < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :working_on, :text
  end
end
