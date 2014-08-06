class DashboardController < ApplicationController

  def index
    @admins = Person.admin
  end

end
