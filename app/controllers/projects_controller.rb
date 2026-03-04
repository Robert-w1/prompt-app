class ProjectsController < ApplicationController
  before_action :enable_sidebar
  before_action :set_project, only: [:show]
  def index
    @projects = current_user.projects
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      redirect_to @project
    else
      render :new
    end
  end
  def show
  end

  private

  def enable_sidebar
    @show_sidebar = true
  end

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
