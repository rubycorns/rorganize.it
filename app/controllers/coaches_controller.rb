class CoachesController < ApplicationController
  def index
    ordered_coaches = Person.workshop_coach.order_by_name
    coaches_by_region = ordered_coaches.filtered_by_region(params, signed_in?)

    @willing_to_travel = params[:willing_to_travel] == '1'
    @coaches = @willing_to_travel ? coaches_by_region.willing_to_travel : coaches_by_region
    @cities  = Person.workshop_coach.visible_locations_for(:cities, signed_in?)
    @countries = Person.workshop_coach.visible_locations_for(:countries, signed_in?)
  end
end
