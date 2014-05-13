class StudentMembership < Membership

  belongs_to :person, foreign_key: :person_id
end
