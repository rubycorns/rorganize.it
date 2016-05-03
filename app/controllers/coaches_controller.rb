class CoachesController < ApplicationController
  def index
    @coaches = Person.workshop_coach.order_by_name
    @coaches = @coaches.by_country(params[:country]) if params[:country].present?
    @coaches = @coaches.by_city(params[:city]) if params[:city].present?
    @coaches = @coaches.willing_to_travel if params[:willing_to_travel] == '1'
    @cities  = Person.workshop_coach.cities
    @countries = Person.workshop_coach.countries
  end
end