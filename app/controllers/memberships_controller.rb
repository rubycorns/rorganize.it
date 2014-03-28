class MembershipsController < ApplicationController

  def create
    @person = Person.find(current_person.id)
    @group = Group.find(params[:person][:group_id])
    if @person.update(group_id: @group.id)
      flash[:success] = "Welcome to #{@group.name}!"
      redirect_to group_path(@group)
    end
  end

  def update
    @person = Person.find(current_person.id)
    if @person.update(group_id: nil)
      flash[:success] = "You have left your group. No doubt they will miss you. Please consider
      buying everyone cake on your last day."
      redirect_to groups_path
    end
  end
end