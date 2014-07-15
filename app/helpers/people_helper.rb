module PeopleHelper
  def logged_in?(person)
    current_person && current_person == person
  end
end