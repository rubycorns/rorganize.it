class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :person_id, null: false
      t.text :body, null: false
      t.integer :topic_id, null: false

      t.timestamps
    end
  end
end
