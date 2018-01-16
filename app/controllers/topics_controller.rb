class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_person!, only: [:edit, :update, :destroy]
  before_action :validate_user_group_member, only: [:edit, :update, :destroy]

  def edit
    @group = Group.find(params[:group_id])
  end

  def index
    topics = Topic.where(group: params[:group_id])
    @covered_topics, @future_topics = topics.partition { |topic| topic.covered? }
    @group = Group.where(id: params[:group_id]).first
    @topic = Topic.new(group_id: params[:group_id], person_id: current_person)
  end

  def show
    @group = @topic.group
    @comments = Comment.where(topic: @topic)
    @comment = Comment.new
  end

  def create
    @topic = Topic.new(topic_params)
    @group = @topic.group
    @topic.person = current_person

    if @topic.save
      redirect_to group_topics_path(@topic.group.id), notice: 'Topic was successfully created. If you bring cake, people
      will be more willing to discuss it with you.'
    else
      render action: 'new'
    end
  end

  def update
    if topic_params['covered']
      @topic.touch(:covered_at)
      redirect_to group_topics_path(@topic.group.id), notice: 'Topic was covered. Time for cake!'
    elsif @topic.update(topic_params)
      redirect_to group_topics_path(@topic.group.id), notice: 'Topic was successfully updated. All efforts, nomatter how small, deserve cake.'
    else
      render action: 'edit'
    end
  end

  def destroy
    group = @topic.group
    @topic.destroy
    redirect_to group_topics_path(group.id), notice: 'You deleted the topic. Cake will lessen the loss.'
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:body, :group_id, :full_name, :covered)
  end

  def validate_user_group_member
    group = Group.friendly.find(params[:group_id])
    unless group.editable_by? current_person
      redirect_to group_path(params[:group_id]),
                  notice: 'You are not allowed to do that'
    end
  end
end
