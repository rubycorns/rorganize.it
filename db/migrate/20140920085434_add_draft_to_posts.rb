class AddDraftToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :draft, :boolean, null: false, default: false
  end
end
