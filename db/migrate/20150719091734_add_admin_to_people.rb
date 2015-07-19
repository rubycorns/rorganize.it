class AddAdminToPeople < ActiveRecord::Migration
  def change
    add_column :people, :admin, :boolean, default: false
  end
end
