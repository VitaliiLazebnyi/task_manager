class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task,
                only: [:edit, :update, :destroy, :update_priority, :switch_done]
  before_action :set_project,
                only: [:new, :edit, :update]
  before_action :validate_ownership!,
                only: [:edit, :update, :destroy, :update_priority, :switch_done]

  def new
    @task = @project.tasks.new
  end

  def create
    @task = Task.new(task_params)

    if @task.project.user != current_user
      # If user changes ProjectId manually
      # in order to add task to someone
      # just render 'new' page again
      render :new, status: :unauthorized
      return
    elsif @task.save
      redirect_to @task.project
    else
      render :new
    end
  end

  def edit; end

  def update
    if @project.user != current_user
      # Should be validated that user can't
      # change tasks in project where he's
      # not owner.
      render :edit, status: :unauthorized
      return
    elsif @task.update(task_params)
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

  def switch_done
    @task.switch_done

    redirect_to @task.project
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:project_id, :title, :priority, :deadline, :done)
  end

  def validate_ownership!
    redirect_to projects_path if @task.project.user != current_user
  end
end
