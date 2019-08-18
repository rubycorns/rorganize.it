class RemoveAndAddProviderUid < ActiveRecord::Migration[5.1]
  def change
    remove_column :people, :provider
    remove_column :people, :uid

    add_column :people, :provider, :string
    add_column :people, :uid, :string
  end
end
