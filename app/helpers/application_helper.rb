module ApplicationHelper
  def convert_markdown(markdown)
    rendered = MarkdownRenderer.to_html(markdown)
    rendered.html_safe
  end

  def link_to_s3_file(file)
    link_to(file.title, "#{S3::AWS_BASE_URL}/#{file.key}")
  end

  def project_logo(project)
    image_tag(project.logo.url(:standard),
              srcset: "#{project.logo.url} 2x",
              alt: "#{project.title} Project Logo")
  end

  def year
    Date.today.year
  end

  def current_path
    url_for
  end
end
