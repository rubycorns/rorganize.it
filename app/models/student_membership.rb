class StudentMembership < Membership

  belongs_to :student, foreign_key: :person_id
end
