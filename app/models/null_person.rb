class NullPerson

  def admin?
    false
  end

  def can_join_group?
    false
  end

  def member_of?(group)
    false
  end

  def admin_member_of?(group)
    false
  end

end
