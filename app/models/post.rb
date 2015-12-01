# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  description  :text
#  picture      :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  person_id    :integer
#  draft        :boolean          default(FALSE), not null
#  slug         :string(255)
#  published_at :datetime
#

class Post < ActiveRecord::Base

  scope :published_descending_order, -> { where(draft: false).order(published_at: :desc) }
  scope :published_ascending_order, -> { where(draft: false).order(published_at: :asc) }
  scope :draft, -> { where(draft: true).order(created_at: :desc) }
  scope :older, -> (date){ where("published_at < ?", date) }
  scope :newer, -> (date){ where("published_at > ?", date) }

  validates :title, presence: true
  validates :description, presence: true

  belongs_to :person

  mount_uploader :picture, PictureUploader

  extend FriendlyId
  friendly_id :title, use: :slugged

  def set_published_at!
    update_attribute(:published_at, Time.now.utc)
  end

  def older_post
    Post.published_descending_order.older(published_at).first
  end

  def newer_post
    Post.published_ascending_order.newer(published_at).last
  end
end
