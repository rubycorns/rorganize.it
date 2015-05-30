class CoachesController < ApplicationController
  def index
    @coaches = Person.where(:willing_to_coach => true)
  end
end
