class TopicCommentsController < ApplicationController
  def index
    binding.pry
    @topic_comments = TopicComment.all
  end

end
