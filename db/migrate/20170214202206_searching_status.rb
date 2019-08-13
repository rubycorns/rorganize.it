class SearchingStatus < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :searching_group, :boolean, default: false, null: false
    add_column :groups, :searching_coaches, :boolean, default: false, null: false
    add_column :groups, :searching_students, :boolean, default: false, null: false
    add_column :groups, :searching_location, :boolean, default: false, null: false
  end
end
