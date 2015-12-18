class ProjectsController < ApplicationController
  def index
    @featured = Project.featured
    @regular = Project.regular
  end

  def show
    @project = Project.find(params[:id])
  end
end
