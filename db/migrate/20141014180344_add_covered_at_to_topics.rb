class AddCoveredAtToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :covered_at, :datetime
  end
end
