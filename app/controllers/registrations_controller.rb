class RegistrationsController < Devise::RegistrationsController
  include ParamsHelper
  before_action :trim_params, only: [:create]

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
end
