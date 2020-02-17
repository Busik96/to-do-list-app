# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :current_task, only: %i[edit destroy update finish]
  before_action :index_view_details, only: %i[index create]

  def index; end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      flash[:success] = 'Task added correctly!'
      redirect_to tasks_path
    else
      flash[:error] = 'Something went wrong!'
      render 'index'
    end
  end

  def edit
    authorize @task
  end

  def update
    authorize @task
    if @task.update(task_params)
      flash[:success] = 'Task updated correctly!'
      redirect_to tasks_path
    else
      flash[:error] = 'Something went wrong!'
      render 'edit'
    end
  end

  def destroy
    authorize @task
    @task.destroy
    flash[:success] = 'Task deleted correctly!'
    redirect_to tasks_path
  end

  def finish
    @task.update(task_params)
    redirect_to tasks_path
  end

  private

  def index_view_details
    @tasks = current_user.tasks
    @tasks_pending = current_user.tasks.pending
    @tasks_finished = current_user.tasks.finished
    @task = Task.new
  end

  def current_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :address, :due_time, :due_date, :finished)
  end
end
