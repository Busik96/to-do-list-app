# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :current_task, only: %i[edit destroy update]

  def index
    @tasks = current_user.tasks
    @task = Task.new
  end

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

  def edit; end

  def update
    if @task.update(task_params)
      flash[:success] = 'Task updated correctly!'
      redirect_to tasks_path
    else
      flash[:error] = 'Something went wrong!'
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'Task deleted correctly!'
    redirect_to tasks_path
  end

  private

  def current_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :address, :due_time, :due_date)
  end
end
