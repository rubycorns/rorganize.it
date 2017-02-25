class CoachesController < ApplicationController
  def index
    coaches = Person.workshop_coach.order_by_name
                .filtered_by_region(params)
                .filtered_by_visibility(signed_in?)

    @willing_to_travel = params[:willing_to_travel] == '1'
    @coaches = @willing_to_travel ? coaches.willing_to_travel : coaches
    @cities  = Person.workshop_coach.visible_locations_for(:cities, signed_in?)
    @countries = Person.workshop_coach.visible_locations_for(:countries, signed_in?)

    page = (params[:page] || 1).to_i

    @paginated_coaches = @coaches.paginate(page: page, per_page: 30)
    @alphabetically_grouped_coaches = @paginated_coaches.grouped_alphabetically

    @paginated_alphabetical_list = @alphabetically_grouped_coaches.keys
    @total_alphabetical_list = coaches.grouped_alphabetically.keys
  end
end
