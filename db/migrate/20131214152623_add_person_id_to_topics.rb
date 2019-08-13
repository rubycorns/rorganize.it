class AddPersonIdToTopics < ActiveRecord::Migration[5.1]
  def change
    add_column :topics, :person_id, :integer
  end
end
