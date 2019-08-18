class AddWebsiteToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :website, :string
  end
end
