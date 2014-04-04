class MembershipsController < ApplicationController
  before_action :authenticate_person!

  def create
    @person = Person.find(current_person.id)
    @group = Group.find(params[:membership][:group_id])

    @person.join(@group)
      flash[:success] = "Welcome to the group #{@group.name}! Please consider buying everyone cake on your first day."
      PersonMailer.new_member_email(@group, @person).deliver
      redirect_to group_path(@group)
  end


  def destroy
    @person = Person.find(current_person.id)
    @group = Group.find(params[:membership][:group_id])

    @person.leave(@group)
      flash[:success] = leave_message
      redirect_to groups_path
  end


  private

  def leave_message
    "You have left your group. No doubt they will miss you." +
      " Please consider buying everyone cake on your last day."
  end
end
