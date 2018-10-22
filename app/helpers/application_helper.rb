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

  def country_names_for_select(countries)
    countries.map { |c| [country_name_from_code(c), c] }
  end

  def country_name_from_code(country)
    country = ISO3166::Country[country]
    raise NoSuchCountry unless country
    country.name
  end

  def current_person
    @current_person ||=  super || NullPerson.new
  end

  def overview_filter(name)
    title_string = name
    if params['city'] || params['country'] then
      strings = []
      strings.push(" #{params['city']}") if params['city'].present?
      strings.push(" #{country_name_from_code(params['country'])}") if params['country'].present?
      title_string += " in#{strings.join(',')}"
    else
      title_string += ' overview'
    end
    title_string
  end

  def split_mastodon_handle(handle)
    splitted_arr = handle.split('@')
    {
      username: splitted_arr.first,
      host: splitted_arr.last
    }
  end
end
