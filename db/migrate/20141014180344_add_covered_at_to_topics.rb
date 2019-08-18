class AddCoveredAtToTopics < ActiveRecord::Migration[5.1]
  def change
    add_column :topics, :covered_at, :datetime
  end
end
