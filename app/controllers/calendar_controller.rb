class CalendarController < ApplicationController
  def index
    @view = params[:view] || "month"
    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    @tasks = Task.where.not(due_date: nil)

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
end
