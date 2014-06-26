# == Schema Information
#
# Table name: groups
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  address           :string(255)
#  time              :string(255)
#  number_of_members :integer
#  created_at        :datetime
#  updated_at        :datetime
#  picture           :string(255)
#  twitter           :string(255)
#  contact           :text
#  activities        :text
#  latitude          :float
#  longitude         :float
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
  geocoded_by :address
  after_validation :geocode

  def is_editable_by?(person)
    people.include?(person)
  end

  def is_deletable_by?(person)
    person && person.has_role?(:admin)
  end
end
