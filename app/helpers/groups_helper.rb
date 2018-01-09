module GroupsHelper

  def show_join_group_button?(person, group)
    return true unless logged_in?(person)
    !person.member_of?(group)
  end

  def show_member_buttons?(person, group)
    if !logged_in?(person)
      false
    else
      person.member_of?(group)
    end
  end

  def group_location(group)
    [group.street, group.zip, group.city, group.country_name].select {|x| x.present? }.join(', ')
  end

  def group_searching_fors(group)
    fors = []
    if group.searching_coaches?
      fors.push('coaches')
    end
    if group.searching_students?
      fors.push('students')
    end
    if group.searching_coaches?
      fors.push('place to meet')
    end
    fors
  end

  def group_subnav_active_class(active_match)
    if @subnav_active == active_match
      return 'active'
    end
  end
end
