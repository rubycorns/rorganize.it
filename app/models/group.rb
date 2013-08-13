class Group < ActiveRecord::Base
  
  has_many :students
  mount_uploader :picture, PictureUploader

  
end
