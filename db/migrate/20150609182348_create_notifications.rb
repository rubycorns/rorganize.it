class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :person
      t.belongs_to :group
      t.datetime :viewed_at
      t.string :content
      t.timestamps
    end
  end
end
