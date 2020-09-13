class Admin::ProjectsController < AdminController
  def index
    @projects = Project.by_position
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to admin_projects_path
    else
      flash[:error] = t('flashes.project.create.error')
      render :new
    end
  end

  def edit
    @project = find_project
  end

  def update
    @project = find_project
    if @project.update(project_params)
      redirect_to admin_projects_path
    else
      flash[:error] = t('flashes.project.update.error')
      render :edit
    end
  end

  def sort
    ids = params[:project]
    positions = (1..ids.count).map { |index| { position: index } }
    Project.update(ids, positions)
    head :accepted
  end

  def destroy
    project = find_project
    if !project.destroy
      flash[:error] = t('flashes.project.delete.error')
    end
    redirect_to admin_projects_path
  end

  private

  def project_params
    params.require(:project).
           permit(:title,
                  :logo,
                  :role,
                  :website,
                  :description,
                  :featured,
                  :slug,
                  :published)
  end

  def find_project
    @project = Project.find_by(slug: params[:id])
  end
end
