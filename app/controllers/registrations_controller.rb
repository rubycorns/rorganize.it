class RegistrationsController < Devise::RegistrationsController
  def update
    @person = Person.find(current_person.id)
    if @person.update_without_password(person_params)
      set_flash_message :notice, :updated
      redirect_to @person
    else
      render 'edit'
    end
  end

  private

  def person_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end
end
