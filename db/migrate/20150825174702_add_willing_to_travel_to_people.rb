class AddWillingToTravelToPeople < ActiveRecord::Migration
  def change
    add_column :people, :willing_to_travel, :boolean, default: false
  end
end
