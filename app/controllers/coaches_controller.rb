class CoachesController < ApplicationController
  def index
    ordered_coaches = Person.workshop_coach.order_by_name

    @coaches = ordered_coaches.filtered_by_params(params, signed_in?)
    @cities  = Person.workshop_coach.visible_locations_for(:cities, signed_in?)
    @countries = Person.workshop_coach.visible_locations_for(:countries, signed_in?)
  end
end
