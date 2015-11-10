class AddWebsiteToPeople < ActiveRecord::Migration
  def change
    add_column :people, :website, :string
  end
end
