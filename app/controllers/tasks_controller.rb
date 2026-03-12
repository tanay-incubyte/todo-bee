class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy toggle_complete]

  def index
    @tasks = Task.newest_first
    @tasks = @tasks.by_priority(params[:priority]) if params[:priority].present?
    @tasks = @tasks.by_category(params[:category]) if params[:category].present?
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task), notice: "Task was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def toggle_complete
    @task.toggle_completion!
    redirect_to tasks_path
  end

  def destroy
    @task.destroy!
    redirect_to tasks_path, notice: "Task was successfully deleted."
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :priority, :category_id)
  end
end
