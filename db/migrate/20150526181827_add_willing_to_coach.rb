class AddWillingToCoach < ActiveRecord::Migration
  def change
    add_column(:people, :willing_to_coach, :boolean)
  end
end
