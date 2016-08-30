class CommentsController < ApplicationController

  before_action :authenticate_person!

  def edit
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to group_topic_path(@comment.topic.group, @comment.topic), notice: 'Comments and cake!'
    else
      redirect_to group_topic_path(@comment.topic.group, @comment.topic), notice: 'Something is wrong, no cake yet!'
    end
  end

  def update
  end

  def destroy
  end

  private
  
  def comment_params
    params.require(:comment).permit(:body, :person_id, :topic_id)
  end
  
end
