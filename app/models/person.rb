class Person < ActiveRecord::Base
  belongs_to :group
  mount_uploader :picture, PictureUploader

  def full_name
    [first_name, last_name].join(' ')
  end

end
