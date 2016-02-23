class CoachesController < ApplicationController
  def index
    @coaches = Person.where(workshop_coach: true)
    @coaches = @coaches.by_country(params[:country]) if params[:country].present?
    @coaches = @coaches.by_city(params[:city]) if params[:city].present?
    @coaches = @coaches.willing_to_travel if params[:willing_to_travel] == '1'

    @cities = Person.where(workshop_coach: true).cities
    @countries = Person.where(workshop_coach: true).countries
  end
end
