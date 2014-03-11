class CoachesController < ApplicationController
  before_action :authenticate_person!

  def index
    @coaches = Coach.all
  end

  def show
    @coach = Coach.find(params[:id])
  end
end
