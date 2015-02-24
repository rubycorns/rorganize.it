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

class Group < ActiveRecord::Base
  include TwitterHandle

  FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  has_many :students, through: :student_memberships, source: :person
  has_many :coaches, through: :coach_memberships, source: :person
  has_many :topics
  has_many :people, through: :memberships
  has_many :memberships, dependent: :destroy
  has_many :student_memberships
  has_many :coach_memberships

  validates :name, presence: true
  validates :email, format: { with: FORMAT }, allow_blank: true

  mount_uploader :picture, PictureUploader
  geocoded_by :location
  after_validation :geocode

  attr_accessor :join_as_coach

  def editable_by?(person)
    people.include?(person)
  end

  def deletable_by?(person)
    person && person.has_role?(:admin)
  end

  def not_full?
    !full
  end

  def location
    [address, city, country].join(' ')
  end
end
