class PeopleController < ApplicationController
  before_action :authenticate_person!, except: [:index]
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def index
    @people = Person.order(:first_name).order(:last_name)
    @people = @people.by_country(params[:country]) if params[:country].present?
    @people = @people.by_city(params[:city]) if params[:city].present?

    @cities = @people.cities
    @countries = @people.countries
  end

  def show
  end

  def edit
  end

  def update
    if @person.update_attributes person_params
      redirect_to person_path(@person), notice: 'You updated your profile! '\
        'Please indulge in some cake and pat yourself on the back for a job well done.'
    else
      render action: 'edit'
    end
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:first_name, :last_name, :email,
    :picture, :twitter, :working_on, :workshop_coach, :city, :country, :willing_to_travel)
  end
end
