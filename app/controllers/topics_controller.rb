class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :validate_user_group_member, except: [:index, :show]
  before_action :authenticate_person!

  def index
    @topics = Topic.all
  end

  def show
  end

  def new
    @topic = Topic.new
  end

  def edit
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.person = current_person

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic.group, notice: 'Topic was successfully created.' }
        format.json { render action: 'show', status: :created, location: @topic }
      else
        format.html { render action: 'new' }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic.group, notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    group = @topic.group
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to group_path(group) }
      format.json { head :no_content }
    end
  end

  private
  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:body, :group_id, :full_name)
  end

  def validate_user_group_member
    unless current_person.group_id == params[:group_id].to_i
      redirect_to group_path(params[:group_id]),
                  notice: 'You are not allowed to do that'
    end
  end
end
