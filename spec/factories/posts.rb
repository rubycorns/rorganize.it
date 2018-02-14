# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  description  :text
#  picture      :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  person_id    :integer
#  draft        :boolean          default(FALSE), not null
#  slug         :string(255)
#  published_at :datetime
#

FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "A blogPost #{n}" }
    description 'about stuff'
    sequence(:slug) { |n| "a-blogpost-#{n}" }
  end
end
