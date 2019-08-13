class DeleteTypeColumnFromPeople < ActiveRecord::Migration[5.1]
  def change
    remove_column :people, :type, :string
  end
end
