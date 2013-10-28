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

  def has_twitter
    twitter && twitter != ''
  end

  def twitter_handle
    if has_twitter
      twitter_handle = '@' + twitter
    else
      ''
    end
  end

  def twitter_profile_url
    if has_twitter
      twitter_profile_url = 'https://twitter.com/' + twitter
    else
      ''
    end
  end

  def has_group
    group && group != ''
  end

  def full_name
    [first_name, last_name].join(' ')
  end

end
