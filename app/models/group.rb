class Group < ActiveRecord::Base
  
  mount_uploader :picture, PictureUploader
  
end
