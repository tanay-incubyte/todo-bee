require "application_system_test_case"

class CalendarTest < ApplicationSystemTestCase
  setup do
    @today = Date.today
    @task_today = Task.create!(title: "Today's task", due_date: @today)
    @task_tomorrow = Task.create!(title: "Tomorrow's task", due_date: @today + 1.day)
    @task_next_week = Task.create!(title: "Next week task", due_date: @today + 7.days)
  end

  test "user views tasks on calendar month view" do
    visit calendar_path

    assert_text "Today's task"
    assert_selector ".calendar-grid"
  end

  test "user navigates to next month" do
    visit calendar_path

    click_on "Next"

    next_month = @today.next_month
    assert_text next_month.strftime("%B %Y")
  end

  test "user switches to week view" do
    visit calendar_path

    click_on "Week"

    assert_selector ".week-view"
  end

  test "user switches to day view" do
    visit calendar_path

    click_on "Day"

    assert_selector ".day-view"
  end

  test "user clicks task to view details" do
    visit calendar_path

    click_on "Today's task"

    assert_current_path task_path(@task_today)
  end

  test "calendar link appears in navigation" do
    visit root_path

    within("nav") do
      assert_link "Calendar"
    end
  end
end
