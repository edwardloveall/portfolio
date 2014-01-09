class ProjectsController < ApplicationController
  def index
    @projects = Project.order('created_at')
  end

  def show
    @project = Project.find(params[:id])
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
  end
end
