# == Schema Information
#
# Table name: memberships
#
#  id         :integer          not null, primary key
#  group_id   :integer
#  person_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  type       :string(255)
#

class CoachMembership < Membership
  belongs_to :person, foreign_key: :person_id
end
