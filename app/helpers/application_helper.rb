module ApplicationHelper
  def convert_markdown(markdown)
    rendered = MarkdownRenderer.to_html(markdown)
    rendered.html_safe
  end

  def project_logo(project)
    logo = project.logo.variant(resize: "174x174")
    logo_2x = project.logo.variant(resize: "348x348")
    image_tag(
      logo,
      srcset: { polymorphic_url(logo_2x) => "2x" },
      alt: "#{project.title} Project Logo"
    )
  end

  def song_tag(sources, **args)
    sources = sources.map { |source| polymorphic_url(source) }
    audio_tag(sources, args)
  end

  def year
    Date.today.year
  end

  def current_path
    url_for
  end

  def pretty_url(url)
    url = URI(url)
    host = url.host.sub('www.', '')
    "#{host}#{url.path}"
  end

  def pretty_date(time)
    time.strftime("%B #{time.day.ordinalize}, %Y")
  end

  def timestamp(time)
    time.strftime('%Y-%m-%d %H:%M')
  end

  def pretty_datetime(time)
    time.strftime("%B #{time.day.ordinalize}, %Y - #{time.hour % 12}:%M %P")
  end
end
