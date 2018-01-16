class MembershipsController < ApplicationController
  before_action :authenticate_person!

  def create
    @person = current_person
    @group = Group.find(params[:membership][:group_id])
    @membership_type = params[:membership][:type]
    if @group.not_full? && @person.join!(@group, type: @membership_type)
      flash[:success] = "Welcome to the group #{@group.name}! Please consider buying everyone cake on your first day."
      PersonMailer.new_member_email(@group, @person).deliver_now if @group.email.present?
      redirect_to group_path(@group)
    else
      redirect_to groups_path
    end
  end

  def update
    membership = Membership.find(params[:id])
    membership.update_attribute(:admin, !membership.admin)
    redirect_to manage_members_group_path(membership.group), notice: "Successfully changed membership status. Just like icing on the cake."
  end

  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    flash[:success] = leave_message
    redirect_to groups_path
  end

  private

  def can_modify_group(group)
    current_person.admin? ||
      current_person.admin_member_of?(group) ||
      current_person.member_of?(group)
  end

  def leave_message
    if @membership.person == current_person
      "You have left your group. No doubt they will miss you." +
      " Please consider buying everyone cake on your last day."
    else
      "You have successfully deleted a person from the group. That was a very tough decision." +
      " Cake will make it all better."
    end
  end
end
