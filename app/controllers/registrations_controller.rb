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

  def destroy
    current_person.destroy
    redirect_to root_path, notice: 'You have successfully deleted your account.
    Please consider sending the programmers of this app one last piece of cake.'
  end

  def after_sign_up_path_for(resource)
    '/welcome'
  end

  private

  def person_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end
end
