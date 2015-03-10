module GroupsHelper

  def show_join_group_button?(person, group)
    return true unless person_signed_in?
    !person.member_of?(group)
  end

  def even_a_button?(group)
    !group.full?
  end

  def show_member_buttons?(person, group)
    if !person_signed_in?
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

  def group_location(group) 
    [group.street, group.zip, group.city, group.country].select {|x| x.present? }.join(', ')
  end

end
