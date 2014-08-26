class MembershipsController < ApplicationController
  before_action :authenticate_person!

  def index
    @group = Group.find(params[:group_id])
    @pending = @group.pending
  end

  def create
    @person = current_person
    @group = Group.find(params[:membership][:group_id])
    if @person.join!(@group, params[:membership][:type], params[:membership][:pending])
      flash[:success] = "You will be alerted when you are accepted into #{@group.name}! In the meantime, we suggest having some cake."
      PersonMailer.new_member_email(@group, @person).deliver if @group.email.present?
      redirect_to group_path(@group)
    else
      redirect_to groups_path
    end
  end

  def update
    @membership = Membership.find(params[:id])


  end

  def destroy
    @membership = Membership.find(params[:id])

    @membership.destroy
    flash[:success] = leave_message
    redirect_to groups_path
  end

  private

  def leave_message
    "You have left your group. No doubt they will miss you." +
      " Please consider buying everyone cake on your last day."
  end
end
