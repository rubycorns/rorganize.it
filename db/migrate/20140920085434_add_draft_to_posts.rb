class AddDraftToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :draft, :boolean, null: false, default: false
  end
end
