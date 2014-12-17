# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  picture     :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  person_id   :integer
#  draft       :boolean
#

class Post < ActiveRecord::Base

  validates :title, presence: true
  validates :description, presence: true

  belongs_to :person

  mount_uploader :picture, PictureUploader

  def to_param
    [id, title.parameterize].join('-')
  end
end
