class AddPersonIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :person_id, :integer
  end
end
