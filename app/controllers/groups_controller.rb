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
      if @group.join_as_coach == '1'
        current_person.join!(@group, 'CoachMembership')
      end
      redirect_to group_path(@group), notice: "Group was successfully created. This calls for cake!"
    else
      render action: "new"
    end
  end

  def edit
  end

  def update
    @group.update_attributes group_params
    redirect_to group_path, notice: 'Group was successfully updated. ' \
    'All efforts, nomatter how small, deserve cake.'
  end

  def show
    topics = Topic.where(group_id: @group.id)
    @covered_topics, @future_topics = topics.partition { |topic| topic.covered? }

    @topic = Topic.new
    @topic.group = @group
  end

  def destroy
    @group.destroy
    redirect_to groups_path, notice: 'Group was successfully deleted. ' \
    'May we suggest drowning your sorrows in some cake?'
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :address, :time,
    :picture, :twitter, :contact, :activities, :email, :level,
    :founded_on, :join_as_coach, :full, :city, :country)
  end

end
