class PeopleController < ApplicationController
  before_action :authenticate_person!, except: [:index]
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def index
    filtered_people = Person.order_by_name.filtered_by_region(params)
                        .filtered_by_visibility(signed_in?)

    @cities = Person.visible_locations_for(:cities, signed_in?)
    @countries = Person.visible_locations_for(:countries, signed_in?)

    page = (params[:page] || 1).to_i

    @paginated_people = filtered_people.paginate(page: page, per_page: 30)
    @alphabetically_grouped_people = @paginated_people.grouped_alphabetically

    @paginated_alphabetical_list = @alphabetically_grouped_people.keys
    @total_alphabetical_list = filtered_people.grouped_alphabetically.keys
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
    :picture, :twitter, :website, :working_on, :workshop_coach, :city, :country, :willing_to_travel, :non_public)
  end
end
