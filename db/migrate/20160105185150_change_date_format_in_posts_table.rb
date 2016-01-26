class ChangeDateFormatInPostsTable < ActiveRecord::Migration
  def change
    change_column :posts, :published_on, :datetime
    rename_column :posts, :published_on, :published_at
  end
end
