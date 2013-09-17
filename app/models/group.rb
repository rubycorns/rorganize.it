class Group < ActiveRecord::Base
  
  has_many :students
  has_many :coaches
  mount_uploader :picture, PictureUploader

  
end
