class CreateTopicComments < ActiveRecord::Migration
  def change
    create_table :topic_comments do |t|
      t.integer :topic_id
      t.string :body
      t.integer :person_id

      t.timestamps
    end
  end
end
