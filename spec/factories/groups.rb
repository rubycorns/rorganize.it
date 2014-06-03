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