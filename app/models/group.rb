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
#  full       :boolean          default(FALSE)
#  city       :string(255)
#  country    :string(255)
#  slug       :string(255)
#  zip        :string(255)
#  street     :string(255)
#

class Group < ApplicationRecord
  include TwitterHandle
  include LocationFilter

  FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  has_many :students, through: :student_memberships, source: :person
  has_many :coaches, through: :coach_memberships, source: :person
  has_many :people, through: :memberships
  has_many :memberships, dependent: :destroy
  has_many :student_memberships
  has_many :coach_memberships
  has_many :invites, dependent: :destroy

  validates :name, presence: true
  validates :email, format: { with: FORMAT }, presence: true
  validates :contact, presence: true
  validates :city, presence: true
  validates :country, presence: true

  mount_uploader :picture, PictureUploader
  geocoded_by :location
  after_validation :geocode

  before_save :capitalize_fields

  scope :open_to_new, -> { where(full: false) }
  scope :active, -> { where(inactive: false) }
  scope :searching_coaches, -> { where('searching_coaches = ?', true) }
  scope :searching_students, -> { where('searching_students = ?', true) }
  scope :searching_location, -> { where('searching_location = ?', true) }

  extend FriendlyId
  friendly_id :name, use: :slugged

  attr_accessor :join_as_coach

  def editable_by?(person)
    people.include?(person)
  end

  def deletable_by?(person)
    person && person.admin?
  end

  def not_full?
    !full
  end

  def active?
    !inactive
  end

  def location
    [address, street, zip, city, country].join(' ')
  end

  def capitalize_fields
    self.city = city.titleize
  end

  def searching?
    searching_coaches || searching_students || searching_location
  end
end
