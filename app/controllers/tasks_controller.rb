class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :update_priority]

  def show; end

  def new
    @project = Project.find(params[:project_id])
    @task    = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task.project
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to @task.project
    else
      render :edit
    end
  end

  def destroy
    @task.destroy

    redirect_to @task.project
  end

  def update_priority
    @task.update_priority(params[:priority])

    redirect_to @task.project
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:project_id, :title, :priority, :deadline, :done)
  end
end
