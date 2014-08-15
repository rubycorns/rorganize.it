class TopicCommentsController < ApplicationController
  def index
    @topic_comments = TopicComment.all
  end

end
