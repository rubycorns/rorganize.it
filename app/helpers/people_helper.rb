module PeopleHelper
  def logged_in?(person)
    current_person && current_person == person
  end

  def admin?
     person_signed_in? && current_person.has_role?('admin')
  end
end