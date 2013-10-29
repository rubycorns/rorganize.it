class Group < ActiveRecord::Base
  
  has_many :students
  has_many :coaches
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
  
end
