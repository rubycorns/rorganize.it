class CoachesController < ApplicationController
  def index
    @coaches = Person.where(workshop_coach: true)
  end
end
