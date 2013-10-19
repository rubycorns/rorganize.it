class Group < ActiveRecord::Base
  
  has_many :students
  has_many :coaches
  mount_uploader :picture, PictureUploader

  def twitter=(handle)
    self[:twitter] = handle.gsub('@', '');
  end
  
end
