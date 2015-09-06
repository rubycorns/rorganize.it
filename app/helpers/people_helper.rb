module PeopleHelper
  def logged_in?(person)
    current_person && current_person == person
  end

  def admin?
     person_signed_in? && current_person.admin?
  end

  def person_avatar(person)
    if person.picture?
      image_tag(person.picture_url(:person_profile), :width => 300)
    else
      image_tag('/avatar.png', size: "40x40")
    end
  end

  def profile_link(person)
    if person_signed_in?
      link_to person.full_name, person_path(person)
    else
      person.full_name
    end
  end

  def coach_location?(person)
    if person.city? || person.country?
      true
    end
  end

end
