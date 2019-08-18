class AddWorkshopCoach < ActiveRecord::Migration[5.1]
  def change
    add_column(:people, :workshop_coach, :boolean)
  end
end
