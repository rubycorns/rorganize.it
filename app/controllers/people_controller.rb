class PeopleController < ApplicationController

  before_action :authenticate_person!, except: [:index]
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def index
    @people = Person.order(:first_name).order(:last_name)
  end

  def show
  end

  def edit
  end

  def update
    @person.update_attributes person_params
    if @person.save
      redirect_to person_path(@person), notice: 'You updated your profile! Please endulge in some cake'\
      'and pat yourself on the back for a job well done.'
    else
      render 'edit'
    end
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:first_name, :last_name, :email, 
    :picture, :twitter, :working_on, :workshop_coach, :admin)
  end
end
