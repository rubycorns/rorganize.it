class Api::V1::CoachesController < Api::V1::BaseController
  def index
    coaches = Person.workshop_coach
    render json: coaches, each_serializer: Api::V1::CoachSerializer
  end
end
