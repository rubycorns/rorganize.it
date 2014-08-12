class DashboardController < ApplicationController

  before_action :authenticate_person!
  before_action :ensure_admin_powers

  def index
    @admins = Person.admin
  end

end
