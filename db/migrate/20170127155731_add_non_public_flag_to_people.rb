class AddNonPublicFlagToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :non_public, :boolean, default: false, null: false
  end
end
