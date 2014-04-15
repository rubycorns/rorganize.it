class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :person
  validates :person_id, presence: true
  validates :group_id, presence: true
  validates :group_id, uniqueness: { scope: :person_id }
end
