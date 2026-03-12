class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy toggle_complete]

  def index
    @tasks = Task.all

    if params[:priority].present?
      priorities = params[:priority].split(',')
      @tasks = @tasks.by_priority(priorities)
    end

    if params[:category].present?
      category_ids = params[:category].split(',')
      @tasks = @tasks.by_category(category_ids)
    end

    if params[:status].present?
      statuses = params[:status].split(',')
      if statuses.include?('active') && statuses.include?('completed')
        # Both selected = all tasks (no filter)
      elsif statuses.include?('active')
        @tasks = @tasks.active
      elsif statuses.include?('completed')
        @tasks = @tasks.completed_tasks
      end
    end

    @tasks = case params[:sort]
    when "due_date"
      @tasks.by_due_date
    when "priority"
      @tasks.by_priority_order
    else
      @tasks.newest_first
    end
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
