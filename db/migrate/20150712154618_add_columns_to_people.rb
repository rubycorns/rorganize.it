class AddColumnsToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :provider, :string
    add_column :people, :uid, :string
  end
end
