class CoachesController < ApplicationController
  def index
    @cities  = Person.workshop_coach.cities
    @countries = Person.workshop_coach.countries
    ordered_coaches = Person.workshop_coach.order_by_name
    @coaches = ordered_coaches.filtered_by_params(params, signed_in?)
  end
end
