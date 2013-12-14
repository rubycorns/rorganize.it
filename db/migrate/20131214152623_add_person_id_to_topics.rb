class AddPersonIdToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :person_id, :integer
  end
end
