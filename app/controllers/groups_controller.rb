class GroupsController < ApplicationController
  
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
     if @group.save
        redirect_to root_path, alert: 'Group was successfully created.'
     else
        render action: "new"
     end
  end

  
  def show
    @group = Group.find(params[:id])
    
  end
  
  # had some problems here, seems like Rails 4 requires 
  # defining parameters in separate method and then passing that in CREATE (?) - should be private
  def group_params
     params.require(:group).permit(:name, :address, :time, :number_of_members)
  end

  
  
end
