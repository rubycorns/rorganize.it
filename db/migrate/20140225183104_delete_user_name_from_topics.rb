class DeleteUserNameFromTopics < ActiveRecord::Migration
  def change
    remove_column :topics, :user_name
  end
end
