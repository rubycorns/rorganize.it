class GroupsController < ApplicationController
  respond_to :html

  before_action :authenticate_person!, except: [:index, :show]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
     if @group.save
        redirect_to root_path, notice: 'Group was successfully created.'
     else
        render action: "new"
     end
  end

  def edit
    @group = Group.find(params[:id])
    if !@group.is_editable_by?(current_person)
      redirect_to root_path, notice: 'You don\'t have permission to view this page.'
    end
  end

  def update
    @group = Group.find(params[:id])
    @group.update_attributes group_params
    redirect_to groups_path, notice: 'Group was successfully updated'
  end

  def show
    @group = Group.find(params[:id])
    @topics = @group.topics
    @topic = Topic.new
    @topic.group = @group
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to groups_path, notice: 'Group was successfully deleted.'
  end

  # had some problems here, seems like Rails 4 requires
  # defining parameters in separate method and then passing that in CREATE (?) - should be private
  def group_params
    params.require(:group).permit(:name, :address, :time, :number_of_members,
    :picture, :twitter, :contact, :activities, :email)
  end

end
