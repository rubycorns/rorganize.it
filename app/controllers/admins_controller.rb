class AdminsController < ApplicationController

  before_action :authenticate_person!
  before_action :ensure_admin_powers

  def create
    person = Person.find(params[:id])
    person.update_attribute(:admin, true)
    redirect_to dashboard_path, notice: "Successfully adminified #{person}"
  end

  def destroy
    person = Person.find(params[:id])
    person.update_attribute(:admin, false)
    redirect_to dashboard_path, notice: "Successfully un-adminified #{person}"
  end
end
