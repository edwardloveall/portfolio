class ProjectsController < ApplicationController
  def index
    @featured = Project.includes(logo_attachment: :blob).featured
    @regular = Project.regular
  end

  def show
    @project = Project.
      includes(logo_attachment: :blob).
      find_by(slug: params[:id])
  end
end
