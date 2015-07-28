class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  #test this?
  def github
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @person = Person.from_omniauth(request.env["omniauth.auth"])

    if @person.persisted?
      sign_in_and_redirect @person, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_person_registration_url
    end
  end
end