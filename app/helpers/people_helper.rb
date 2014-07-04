module PeopleHelper
  def currently_logged_in?
    current_person && current_person.id == @person.id
  end
end