class PeopleController < ApplicationController
  before_action :authenticate_person!

  def index
    @people = Person.order(:first_name).order(:last_name)
  end

  def show
    @person = Person.find(params[:id])
  end
end
