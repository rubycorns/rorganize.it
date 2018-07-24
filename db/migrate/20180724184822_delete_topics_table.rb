class DeleteTopicsTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :topics
  end
end
