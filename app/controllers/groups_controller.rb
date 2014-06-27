class GroupsController < ApplicationController
  respond_to :html

  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_person!, except: [:index, :show]
  before_action :admin_powers, only: [:destroy]
  before_action :member_powers, except: [:index, :show, :new, :create]

  def index
    @groups = Group.order :name
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to groups_path, notice: 'Group was successfully created.'
    else
      render action: "new"
    end
  end

  def edit
  end

  def update
    @group.update_attributes group_params
    redirect_to groups_path, notice: 'Group was successfully updated'
  end

  def show
    @topics = @group.topics
    @topic = Topic.new
    @topic.group = @group
  end

  def destroy
    binding.pry
    @group.destroy
    redirect_to groups_path, notice: 'Group was successfully deleted.'
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :address, :time, :number_of_members,
    :picture, :twitter, :contact, :activities, :email)
  end

  def admin_powers
    group = Group.find(params[:id])
    redirect_to groups_path unless current_person.has_role? :admin
  end

  def member_powers
    group = Group.find(params[:id])
    redirect_to groups_path unless current_person.member_of? group
  end
end
