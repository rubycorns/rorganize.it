class Api::V1::GroupsController < Api::V1::BaseController
  def index
    groups = Group.all
    render json: groups, each_serializer: Api::V1::GroupSerializer
  end

  def show
    group = Group.find(params[:id])
    render json: group, each_serializer: Api::V1::GroupSerializer
  end
end
