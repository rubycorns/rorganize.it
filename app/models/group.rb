class Group < ActiveRecord::Base
  include TwitterHandle
  
  has_many :students
  has_many :coaches
  mount_uploader :picture, PictureUploader
end
