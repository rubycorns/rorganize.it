class MembershipsController < ApplicationController
  before_action :authenticate_person!

  def create
    @person = current_person
    @group = Group.find(params[:membership][:group_id])
    if @group.not_full? && @person.join!(@group, params[:membership][:type])
      flash[:success] = "Welcome to the group #{@group.name}! Please consider buying everyone cake on your first day."
      PersonMailer.new_member_email(@group, @person).deliver_now if @group.email.present?
      redirect_to group_path(@group)
    else
      redirect_to groups_path
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy

    flash[:success] = leave_message
    redirect_to groups_path
  end

  def new
    # here code is needed which creates the message for the membership request
  end

  private

  def leave_message
    if @membership.person == current_person
      "You have left your group. No doubt they will miss you." +
      " Please consider buying everyone cake on your last day."
    else
      "You have successfully deleted a person. That was a very tough decision." +
      " Cake will make it all better."
    end
  end
end
