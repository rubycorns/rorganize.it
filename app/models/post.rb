class Post < ActiveRecord::Base

  validates :title, presence: true
  validates :description, presence: true

  belongs_to :person

  mount_uploader :picture, PictureUploader

end
