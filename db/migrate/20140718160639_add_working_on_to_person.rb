class AddWorkingOnToPerson < ActiveRecord::Migration
  def change
    add_column :people, :working_on, :text
  end
end
