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

  has_many :students
  has_many :coaches
  has_many :topics

  validates :name, presence: true
  validates :email, format: { with: FORMAT }, presence: true

  mount_uploader :picture, PictureUploader
  geocoded_by :address
  after_validation :geocode

  def is_editable_by?(person)
    students.include?(person) || coaches.include?(person)
  end

end
