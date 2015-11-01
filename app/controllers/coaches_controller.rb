class CoachesController < ApplicationController
  def index
    @coaches = Person.where(workshop_coach: true)
    @coaches = @coaches.by_country(params[:country]) if params[:country].present?
    @coaches = @coaches.by_city(params[:city]) if params[:city].present?

    @cities = @coaches.cities
    @countries = @coaches.countries
  end
end
