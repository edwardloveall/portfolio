module ApplicationHelper
  def year
    Date.today.year
  end

  def project_logo(project)
    image_tag(project.logo.url(:standard),
              srcset: "#{project.logo.url} 2x",
              width: Project::LOGO_SIZE,
              height: Project::LOGO_SIZE,
              alt: "#{project.title} Project Logo")
  end
end
