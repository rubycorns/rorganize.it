class ChangeDateFormatInPostsTable < ActiveRecord::Migration[5.1]
  def change
    change_column :posts, :published_on, :datetime
    rename_column :posts, :published_on, :published_at
  end
end
