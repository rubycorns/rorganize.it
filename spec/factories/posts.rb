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

FactoryGirl.define do
  sequence :title do |n|
    "A blogPost #{n}"
  end

  sequence :slug do |n|
    "a-blogpost-#{n}"
  end

  factory :post do
    title :title
    description 'about stuff'
    slug :slug
  end
end
