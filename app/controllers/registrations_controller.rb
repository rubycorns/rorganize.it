class RegistrationsController < Devise::RegistrationsController
  def update
    @person = Person.find(current_person.id)
    if @person.update_without_password(person_params)
      set_flash_message :notice, :updated
      redirect_to after_update_path_for(@person)
    else
      render 'edit'
    end
  end

  private

  def after_update_path_for(resource)
    case resource
    when Student
      student_path(resource)
    when Coach
      coach_path(resource)
    end
  end

  def person_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end
end
