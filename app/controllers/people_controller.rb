class PeopleController < ApplicationController
  before_action :authenticate_person!, except: [:index]
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def index
    ordered_people = Person.order(:first_name).order(:last_name)
    @people = ordered_people
              .filtered_by_region(params)
              .filtered_by_visibility(signed_in?)

    @cities = Person.order(:city).visible_locations_for(:cities, signed_in?)
    @countries = Person.order(:country).visible_locations_for(:countries, signed_in?)

    @grouped_people = @people.group_by{|person| person.first_name.first.capitalize }
    @alphabetical_list = @grouped_people.keys.sort
    @subnav_active = 'index'
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
    params.require(:person).permit(
      :first_name,
      :last_name,
      :email,
      :picture,
      :twitter,
      :website,
      :working_on,
      :workshop_coach,
      :city,
      :country,
      :willing_to_travel,
      :non_public,
      :searching_group,
      :github_handle,
      :remove_picture,
      :mastodon
    )
  end
end
