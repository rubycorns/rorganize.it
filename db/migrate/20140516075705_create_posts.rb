class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.string :picture
      t.string :name

      t.timestamps
    end
  end
end
