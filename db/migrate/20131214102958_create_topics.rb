class CreateTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :topics do |t|
      t.string :user_name
      t.text :body
      t.integer :group_id

      t.timestamps
    end
  end
end
