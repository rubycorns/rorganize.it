class AddPublicationDateToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :published_on, :date
  end
end