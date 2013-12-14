class Group < ActiveRecord::Base
  include TwitterHandle
  
  has_many :students
  has_many :coaches
  mount_uploader :picture, PictureUploader
  geocoded_by :address
  after_validation :geocode
end
