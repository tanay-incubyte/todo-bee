class CalendarController < ApplicationController
  def index
    @view = params[:view] || "month"
    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    @tasks = Task.where.not(due_date: nil)

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

    case @view
    when "month"
      @start_date = @date.beginning_of_month.beginning_of_week(:sunday)
      @end_date = @date.end_of_month.end_of_week(:sunday)
    when "week"
      @start_date = @date.beginning_of_week(:sunday)
      @end_date = @date.end_of_week(:sunday)
    when "day"
      @start_date = @date
      @end_date = @date
    end

    @tasks_by_date = @tasks.where(due_date: @start_date..@end_date).group_by(&:due_date)
  end

  private

  def filter_params
    { priority: params[:priority], category: params[:category], status: params[:status] }.compact_blank
  end
  helper_method :filter_params
end
