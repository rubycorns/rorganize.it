class MembershipsController < ApplicationController

  def create
    @person = Person.find(current_person.id)
    @group = Group.find(params[:person][:group_id])
    if @person.update(group_id: @group.id)
      flash[:success] = "Welcome to #{@group.name}!"
      redirect_to group_path(@group)
    end
  end

end