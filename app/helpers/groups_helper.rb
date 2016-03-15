module GroupsHelper

  def show_join_group_button?(person, group)
    return true unless person_signed_in?
    !person.member_of?(group)
  end

  def group_open?(group)
    !group.full?
  end

  def group_active?(group)
    !group.inactive
  end

  def show_member_buttons?(person, group)
    if !person_signed_in?
      false
    else
      person.member_of?(group)
    end
  end

  def group_location(group)
    [group.street, group.zip, group.city, group.country_name].select {|x| x.present? }.join(', ')
  end

end
