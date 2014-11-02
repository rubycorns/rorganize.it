module GroupsHelper

  def show_join_group_button?(person, group)
    if person == nil # if person not logged in, show the buttons
      true
    elsif group.closed? # if group is closed, do not show the buttons
      false
    elsif !person.member_of?(group) # if person not a member of the group, show the buttons
      true
    end
  end

  def show_member_buttons?(person, group)
    if person.nil?
      false
    else
      person.member_of?(group)
    end
  end

  def groups_map(group)
    map(
      container_id: "group-map",
      center: {
        latlng: [group.latitude, group.longitude],
        zoom: 16
      },
      markers: [
        {
          latlng: [group.latitude, group.longitude],
        }
      ],
      attribution: 'Map data &copy; <a href="http://openstreetmap.org" target="_blank">OpenStreetMap contributors</a>,<a href="https://creativecommons.org/licenses/by-sa/2.0/" target="_blank">CC-BY-SA</a>'
    )
  end

end
