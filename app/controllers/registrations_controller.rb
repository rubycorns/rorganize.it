class RegistrationsController < Devise::RegistrationsController
  before_action :trim_whitespace, only: [:create]

  def destroy
    current_person.destroy
    redirect_to root_path, notice: 'You have successfully deleted your account.
    Please consider sending the programmers of this app one last piece of cake.'
  end

  def after_sign_up_path_for(resource)
    welcome_path
  end

  private

  def person_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end

  def trim_whitespace
    super(params[:person])
  end
end
