# == Schema Information
#
# Table name: people
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  email                  :string(255)      default(""), not null
#  group_id               :integer
#  created_at             :datetime
#  updated_at             :datetime
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  picture                :string(255)
#  twitter                :string(255)
#  working_on             :text
#  willing_to_coach       :boolean
#  workshop_coach         :boolean
#

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

  factory :admin, class: Person do
    first_name 'Super'
    last_name 'Cake'
    email
    password 'tarntest'
    admin true
  end
end
