class RemoveGroupIdFromNotifications < ActiveRecord::Migration
  def change
    remove_column :notifications, :group_id
  end
end
