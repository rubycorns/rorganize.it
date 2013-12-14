module TwitterHandle
	def twitter=(handle)
    self[:twitter] = handle.gsub('@', '');
  end

  def has_twitter?
    twitter && twitter != ''
  end

  def twitter_handle
    if has_twitter?
      twitter_handle = '@' + twitter
    else
      ''
    end
  end

  def twitter_profile_url
    if has_twitter?
      twitter_profile_url = 'https://twitter.com/' + twitter
    else
      ''
    end
  end
end