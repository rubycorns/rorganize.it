class GroupsController < ApplicationController
  respond_to :html

  before_action :set_group, only: [:show, :edit, :update, :destroy, :manage_members]
  before_action :authenticate_person!, only: [:new, :create, :edit, :update, :destroy, :manage_members]
  before_action :ensure_can_destroy, only: [:destroy]
  before_action :ensure_member_powers, only: [:edit, :update]
  before_action :ensure_group_admin_powers, only: [:edit, :update, :manage_members]
  before_action :trim_params, only: [:create, :update]

  def index
    ordered_groups = Group.active.order(:name)
    @groups = ordered_groups.filtered_by_region(params)
    @cities = Group.order(:city).cities
    @countries = Group.order(:country).countries
    @subnav_active = 'index'
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      if @group.join_as_coach == '1'
        current_person.join!(@group, {type: 'CoachMembership', admin: true})
      else
        current_person.join!(@group, admin: true)
      end
      redirect_to group_path(@group), notice: 'Group was successfully created. You are the admin now. This calls for cake!'
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @group.update_attributes group_params
      redirect_to group_path(@group), notice: 'Group was successfully updated. ' \
                                              'All efforts, nomatter how small, deserve cake.'
    else
      render action: 'edit'
    end
  end

  def show
    @students = signed_in? ? @group.students : @group.students.public_profile
    @coaches = signed_in? ? @group.coaches : @group.coaches.public_profile

    @subnav_active = 'show'
  end

  def destroy
    @group.destroy
    redirect_to groups_path, notice: 'Group was successfully deleted. ' \
                                     'May we suggest drowning your sorrows in some cake?'
  end

  def manage_members
  end

  def searching
    @group_coaches = Group.searching_coaches
    @groups = @group_coaches.or(Group.searching_students).or(Group.searching_location)
    @subnav_active = "searching"
  end

  def recent
    @groups = Group.where(created_at: 6.month.ago..Time.current)
    @subnav_active = "recent"
  end

  def inactive
    @groups = Group.where(inactive: true).order(:name)
    @subnav_active = "inactive"
  end

  private

  def ensure_can_destroy
    render_403 unless current_person.admin? || current_person.admin_member_of?(@group)
  end

  def set_group
    @group = Group.friendly.find(params[:id])
  end

  def group_params
    params.require(:group).permit(
      :id,
      :name,
      :address,
      :time,
      :picture,
      :twitter,
      :contact,
      :activities,
      :email,
      :level,
      :founded_on,
      :join_as_coach,
      :full,
      :city,
      :country,
      :street,
      :zip,
      :learning_resources,
      :inactive,
      :allow_male_students,
      :searching_coaches,
      :searching_students,
      :searching_location,
      :mastodon
    )
  end

  def trim_params
    super(params[:group])
  end
end
