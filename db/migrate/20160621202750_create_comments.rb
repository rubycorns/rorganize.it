class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :person_id
      t.text :body
      t.integer :topic_id, null: false

      t.timestamps
    end
  end
end
