class DashboardsController < ApplicationController

  before_action :authenticate_person!
  before_action :ensure_admin_powers

  def show
    @admins, @non_admins = Person.all.partition { |person| person.has_role?(:admin) }
  end

end
