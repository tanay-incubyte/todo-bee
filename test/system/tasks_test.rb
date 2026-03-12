require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  setup do
    @task = Task.create!(title: "Existing task", description: "Some details", due_date: "2026-03-15")
  end

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

  test "user sees error when creating task without title" do
    visit new_task_path

    fill_in "Title", with: ""
    click_on "Create Task"

    assert_text "Title can't be blank"
  end

  test "user sees error when editing task to blank title" do
    visit edit_task_path(@task)

    fill_in "Title", with: ""
    click_on "Update Task"

    assert_text "Title can't be blank"
  end

  test "user toggles task completion from the list" do
    visit tasks_path

    # Task should start as incomplete
    assert_no_selector "#task_#{@task.id}.task-completed"

    # Click toggle to mark complete
    within("#task_#{@task.id}") { click_button "Mark complete" }

    # Wait for page to update — task should now be completed
    assert_selector "#task_#{@task.id}.task-completed"

    # Toggle back to incomplete
    within("#task_#{@task.id}") { click_button "Mark incomplete" }

    # Task should be incomplete again
    assert_no_selector "#task_#{@task.id}.task-completed"
  end

  test "user deletes a task with confirmation" do
    visit task_path(@task)

    accept_confirm("Are you sure you want to delete this task?") do
      click_on "Delete"
    end

    assert_current_path tasks_path
    assert_no_text "Existing task"
  end

  test "user creates a task with priority and sees priority badge" do
    visit new_task_path

    fill_in "Title", with: "Urgent meeting prep"
    select "High", from: "Priority"
    click_on "Create Task"

    assert_text "Urgent meeting prep"
    assert_selector ".priority-high"
  end

  test "user filters tasks by priority" do
    Task.create!(title: "High priority task", priority: "high")
    Task.create!(title: "Low priority task", priority: "low")

    visit tasks_path

    select "High", from: "priority_filter"
    click_on "Filter"

    assert_text "High priority task"
    assert_no_text "Low priority task"
  end

  test "user creates a category and assigns it to a task" do
    visit categories_path
    click_on "New Category"

    fill_in "Name", with: "Work"
    click_on "Create Category"

    assert_text "Work"

    visit new_task_path
    fill_in "Title", with: "Finish report"
    select "Work", from: "Category"
    click_on "Create Task"

    assert_text "Finish report"
    assert_selector ".category-badge", text: "Work"
  end

  test "user filters tasks by category" do
    work = Category.create!(name: "Work")
    personal = Category.create!(name: "Personal")
    Task.create!(title: "Work task", category: work)
    Task.create!(title: "Personal task", category: personal)

    visit tasks_path

    select "Work", from: "category_filter"
    click_on "Filter"

    assert_text "Work task"
    assert_no_text "Personal task"
  end
end
