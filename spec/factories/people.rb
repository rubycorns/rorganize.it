FactoryGirl.define do
  sequence :email do |n|
    "test_#{n}@test.com"
  end

  factory :person do
    first_name 'Ruby'
    last_name 'Corn'
    email
    password 'testtest'
  end
end