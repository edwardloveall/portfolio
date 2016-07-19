class ProjectsController < ApplicationController
  def index
    @featured = Project.featured.by_position
    @regular = Project.regular.by_position
  end

  def show
    @project = Project.find_by(slug: params[:id])
  end
end
