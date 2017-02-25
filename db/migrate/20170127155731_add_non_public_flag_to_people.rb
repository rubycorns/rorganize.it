class AddNonPublicFlagToPeople < ActiveRecord::Migration
  def change
    add_column :people, :non_public, :boolean, default: false, null: false
  end
end
