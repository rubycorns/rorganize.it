# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  body       :text
#  group_id   :integer
#  created_at :datetime
#  updated_at :datetime
#  person_id  :integer
#  covered_at :datetime
#

class Topic < ApplicationRecord
  belongs_to :group
  belongs_to :person

  has_many :comments

  def covered?
    !!covered_at
  end
end
