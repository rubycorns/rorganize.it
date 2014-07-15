class GroupsController < ApplicationController
  respond_to :html

  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_person!, except: [:index, :show]
  before_action :ensure_admin_powers, only: [:destroy]
  before_action :ensure_member_powers, except: [:index, :show, :new, :create, :destroy]

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
    redirect_to group_path, notice: 'Group was successfully updated'
  end

  def show
    @topics = @group.topics
    @topic = Topic.new
    @topic.group = @group
  end

  def destroy
    @group.destroy
    redirect_to groups_path, notice: 'Group was successfully deleted.'
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :address, :time, :number_of_members,
    :picture, :twitter, :contact, :activities, :email, :level, :founded_on)
  end

  def ensure_admin_powers
    redirect_to groups_path unless current_person.has_role?(:admin)
  end

  def ensure_member_powers
    redirect_to groups_path unless current_person.member_of? @group
  end
end
