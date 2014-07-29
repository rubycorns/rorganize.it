module ApplicationHelper

  def flash_class(level)
    case level
      when :notice then "info"
      when :error then "error"
      when :alert then "warning"
      when :success then "success"
    end
  end

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
