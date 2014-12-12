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
    group_image = group.picture_url ? "/uploads/group/picture/#{group.id}/marker.png" : image_url('marker/marker.png')
    map(
      container_id: "group-map",
      center: {
        latlng: [group.latitude, group.longitude],
        zoom: 16
      },
      markers: [
        {
          latlng: [group.latitude, group.longitude],
          icon: {
            icon_url: groupImage,
            icon_size: [40, 50],
            icon_anchor: [20, 50]
          }
        }
      ],
      tile_layer: 'http://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}',
      attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    )
  end

end
