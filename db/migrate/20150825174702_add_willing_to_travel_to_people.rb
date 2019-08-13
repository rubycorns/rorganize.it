class AddWillingToTravelToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :willing_to_travel, :boolean, default: false
  end
end
