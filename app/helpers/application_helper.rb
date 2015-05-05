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

    emoji = Redcarpet::Markdown.new(
      MdEmoji::Render.new(filter_html: true),
      no_intra_emphasis: true,
      autolink: true,
      space_after_headers: false,
      underline: true
    )

    raw emoji.render(text)
  end

end
