class AdminsController < ApplicationController

  before_action :authenticate_person!
  before_action :ensure_admin_powers

  def create
    person = Person.find(params[:admin])
    person.add_role(:admin)
    redirect_to dashboard_path, notice: "Successfully adminified #{person}"
  end

  def destroy
    person = Person.find(params[:person][:admin_id])
    person.remove_role(:admin)
    redirect_to dashboard_path, notice: "Successfully un-adminified #{person}"
  end

end
