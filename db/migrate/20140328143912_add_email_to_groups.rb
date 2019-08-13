class AddEmailToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :email, :string
  end
end
