module PostsHelper

  def show_date(post)
    if post.published_at.present?
      post.published_at.strftime("%d %b %Y")
    else
      "draft created on #{post.created_at.strftime("%d %b %Y")}"
    end
  end
end
