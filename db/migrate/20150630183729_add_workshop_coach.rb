class AddWorkshopCoach < ActiveRecord::Migration
  def change
    add_column(:people, :workshop_coach, :boolean)
  end
end
