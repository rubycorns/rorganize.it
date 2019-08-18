class AddPersonIdToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :person_id, :integer
  end
end
