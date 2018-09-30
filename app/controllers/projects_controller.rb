class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :validate_ownership!, only: [:show, :edit, :update, :destroy]

  def index
    @projects = current_user.projects
  end

  def show; end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.new(project_params)

    if @project.save
      # redirect_to action: 'index'
      redirect_to projects_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @project.update(project_params)
      redirect_to projects_path
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title)
  end

  def validate_ownership!
    redirect_to projects_path if @project.user != current_user
  end
end
