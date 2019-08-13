class AddCityAndCountryToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :city, :string
    add_column :groups, :country, :string
  end
end
