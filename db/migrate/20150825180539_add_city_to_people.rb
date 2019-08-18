class AddCityToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :city, :string
  end
end
