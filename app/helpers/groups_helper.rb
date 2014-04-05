module GroupsHelper

  def show_join_group_button?(person, group)
    if person == nil
      true
    else
      Membership.pluck(:group_id).include?(group.id) == false
    end
  end

  def show_group_member_buttons?(person, group)
    if person == nil
      false
    else
      Membership.pluck(:group_id).include?(group.id) == true
    end
  end
end
