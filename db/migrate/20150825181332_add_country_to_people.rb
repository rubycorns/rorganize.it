class AddCountryToPeople < ActiveRecord::Migration
  def change
    add_column :people, :country, :string
  end
end
