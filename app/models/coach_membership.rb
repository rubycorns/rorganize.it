class CoachMembership < Membership
  belongs_to :coach, foreign_key: :person_id
end
