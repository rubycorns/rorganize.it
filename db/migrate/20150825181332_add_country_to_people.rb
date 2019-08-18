class AddCountryToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :country, :string
  end
end
