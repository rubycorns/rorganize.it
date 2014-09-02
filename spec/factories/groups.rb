# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address    :string(255)
#  time       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  picture    :string(255)
#  twitter    :string(255)
#  latitude   :float
#  longitude  :float
#  contact    :text
#  activities :text
#  email      :string(255)
#  level      :string(255)
#  founded_on :string(255)
#

FactoryGirl.define do
  factory :group do
    name 'Test Group'
    email 'testgroup@email.com'
  end

  factory :second_group, class: Group do
    name 'Second Group'
    email 'secondgroup@email.com'
  end
end
