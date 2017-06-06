# == Schema Information
#
# Table name: people
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  email                  :string(255)      default(""), not null
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
#  working_on             :text
#  workshop_coach         :boolean
#

class Person < ActiveRecord::Base
  include TwitterHandle
  include LocationFilter

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:github]

  has_many :groups, through: :memberships
  has_many :memberships, dependent: :destroy
  has_many :topics
  has_many :posts

  mount_uploader :picture, PictureUploader

  validates :first_name, presence: true

  before_validation :prepend_http

  scope :admin, -> { where(admin: true) }
  scope :willing_to_travel, -> { where(willing_to_travel: true) }
  scope :order_by_name, -> { order("lower(first_name) ASC, lower(last_name) ASC") }
  scope :workshop_coach, -> { where(workshop_coach: true)}
  scope :public_profile, -> { where(non_public: false) }
  scope :searching_group, -> { where(searching_group: true) }

  scope :visible_locations_for, -> (location_type, signed_in) {
    signed_in ? send("#{location_type}") : public_profile.send("#{location_type}")
  }
  scope :filtered_by_visibility, -> (signed_in) {
    signed_in ? all : public_profile
  }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |person|
      person.email = auth.info.email
      person.password = Devise.friendly_token[0,20]
      person.name = auth.info.name   # assuming the user model has a name
      person.remote_picture_url = auth.info.image # assuming the user model has an image
    end
  end

  def merge_with_github!(github_person)
    self.provider = github_person.provider
    self.uid = github_person.uid
    self.save!
  end

  def has_group?
    groups.empty? == false
  end

  def full_name
    if last_name.present?
      [first_name, last_name].join(' ')
    else
      first_name
    end
  end

  def name
    full_name
  end

  def name=(string)
    names = string.split(' ')

    if names.count > 1
      self.first_name = names.first
      self.last_name = names.drop(1).join(' ')
    else
      self.first_name = names.first
      self.last_name = nil
    end
  end

  def to_s
    full_name
  end

  def join!(group, type = 'StudentMembership')
    memberships.create!(group_id: group.id, type: type)
  end

  def member_of?(group)
    # double !! makes it return a boolean
    !!memberships.find_by(group_id: group.id)
  end

  def <=>(other)
    name <=> other.name
  end

  def can_join_group?
    true
  end

  private
    def prepend_http
      if website.present?
        website.prepend("http://") unless website_has_protocol?
      end
    end

    def website_has_protocol?
      !!(website =~ %r{\Ahttp://|\Ahttps://|\A//})
    end
end
