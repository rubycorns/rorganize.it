class AddLongLatToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :latitude, :float
    add_column :groups, :longitude, :float
  end
end
