FactoryGirl.define do
  factory :group do
    name 'Test Group'
    email 'testgroup@email.com'

    factory :second_group do
      name 'Second Group'
      email 'secondgroup@email.com'
    end
  end
end