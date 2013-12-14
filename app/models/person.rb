class Person < ActiveRecord::Base
  include TwitterHandle
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :group
  has_many :topics
  mount_uploader :picture, PictureUploader

  def has_group?
    group && group != ''
  end

  def full_name
    [first_name, last_name].join(' ')
  end

end
