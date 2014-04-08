module GroupsHelper

  def show_join_group_button?(person, group)
    if person == nil
      true
    else
      !person.member_of?(group)
    end
  end

  def show_group_member_buttons?(person, group)
    if person == nil
      false
    else
      person.member_of?(group)
    end
  end
end
