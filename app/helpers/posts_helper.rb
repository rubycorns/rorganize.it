module PostsHelper

  def markdown(text)
    redcarpet = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      autolink: true,
      space_after_headers: false,
      underline: true
    )
    raw redcarpet.render(text)
  end
end
