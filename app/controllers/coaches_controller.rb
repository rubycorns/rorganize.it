class CoachesController < ApplicationController
  def index
    @coaches = Person.where(workshop_coach: true)
    @cities = @coaches.map{ |coach| coach.city }.uniq
    @countries = @coaches.map{ |coach| coach.country }.uniq

    @coaches = @coaches.by_country(params[:country]) if params[:country].present?
    @coaches = @coaches.by_city(params[:city]) if params[:city].present?

  end
  
end
