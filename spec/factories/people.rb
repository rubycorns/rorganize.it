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

  factory :second_person, class: Person do
    first_name 'Tarn'
    last_name 'Shoes'
    email
    password 'tarntarn'
  end
end
