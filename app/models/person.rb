# == Schema Information
#
# Table name: people
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  email                  :string(255)      default(""), not null
#  type                   :string(255)
#  group_id               :integer
#  created_at             :datetime
#  updated_at             :datetime
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  picture                :string(255)
#  twitter                :string(255)
#

class Person < ActiveRecord::Base
  rolify
  include TwitterHandle
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :groups, through: :memberships
  has_many :memberships, dependent: :destroy
  has_many :topics
  has_many :posts

  mount_uploader :picture, PictureUploader

  validates :first_name, presence: true

  def has_group?
    groups.empty? == false
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def join!(group, type = 'StudentMembership')
    memberships.create!(group_id: group.id, type: type)
  end

  def leave!(group)
    # group is set in the controller, and returns the MEMBERSHIP RELATION.
    # this means you don't pass in a group object, you pass in a membership object.
    # therefore, instead of finding group.id, we have to find group.group_id
    # (which is essentially membership.group_id)
    memberships.find_by(group_id: group.group_id).destroy
  end

  def member_of?(group)
    # double !! makes it return a boolean
    !!memberships.find_by(group_id: group.id)
  end
end
