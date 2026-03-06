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

  def edit
  @project = Project.find(params[:id])
end

def update
  @project = Project.find(params[:id])
  if @project.update(project_params)
    redirect_to projects_path, notice: "Project updated."
  else
    render :edit, status: :unprocessable_entity
  end
end

def destroy
  @project = Project.find(params[:id])
  @project.destroy
  redirect_to projects_path, notice: "Project deleted."
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

def edit
  @project = Project.find(params[:id])
end

def update
  @project = Project.find(params[:id])
  if @project.update(project_params)
    redirect_to projects_path, notice: "Project updated."
  else
    render :edit, status: :unprocessable_entity
  end
end

def destroy
  @project = Project.find(params[:id])
  @project.destroy
  redirect_to projects_path, notice: "Project deleted."
end
