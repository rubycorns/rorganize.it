class CommentsController < ApplicationController

  before_action :authenticate_person!

  def edit
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to @comment.topic.group, notice: 'Comment posted!'
    else
      redirect_to @comment.topic.group, notice: 'Whoopsie!'
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
