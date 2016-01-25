module ApplicationHelper
  def year
    Date.today.year
  end

  def project_logo(project)
    image_tag(project.logo.url(:standard),
              srcset: "#{project.logo.url} 2x",
              alt: "#{project.title} Project Logo")
  end

  def convert_markdown(markdown)
    rendered = MarkdownRenderer.to_html(markdown)
    rendered.html_safe
  end
end
