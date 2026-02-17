require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  test "user creates a task and sees it in the list" do
    visit tasks_path

    within("nav") { click_on "New Task" }

    fill_in "Title", with: "Buy groceries"
    fill_in "Description", with: "Milk, eggs, bread"
    execute_script("document.getElementById('task_due_date').value = '2026-03-01'")

    click_on "Create Task"

    assert_text "Buy groceries"

    click_on "Buy groceries"

    assert_text "Buy groceries"
    assert_text "Milk, eggs, bread"
    assert_text "March 01, 2026"
  end
end
