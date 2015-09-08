class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def github
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @person = Person.from_omniauth(request.env["omniauth.auth"])
    rorganize_person = Person.where(email: @person.email).where(provider: nil).first

    if rorganize_person.present?
      rorganize_person.merge_with_github!(@person)
      redirect_to rorganize_person
      set_flash_message(:notice, :success, kind: "Github") if is_navigational_format?
    elsif @person.persisted?
      sign_in_and_redirect @person, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_person_registration_url
    end
  end

end