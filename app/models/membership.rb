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

class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :person
  validates :person_id, presence: true
  validates :group_id, presence: true
  validates :group_id, uniqueness: { scope: :person_id }

  def name
    type.gsub('Membership', '')
  end
end
