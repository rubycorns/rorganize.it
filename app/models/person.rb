class Person < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :group
  mount_uploader :picture, PictureUploader

  def twitter=(handle)
    self[:twitter] = handle.gsub('@', '');
  end

  def full_name
    [first_name, last_name].join(' ')
  end

end
