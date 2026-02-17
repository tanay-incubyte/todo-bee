require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = Task.create!(title: "Existing task", description: "Some details", due_date: "2026-03-01")
  end

  # Index
  test "GET /tasks returns success" do
    get tasks_path
    assert_response :success
  end

  # Show
  test "GET /tasks/:id returns success" do
    get task_path(@task)
    assert_response :success
  end

  # New
  test "GET /tasks/new returns success" do
    get new_task_path
    assert_response :success
  end

  # Create - valid
  test "POST /tasks creates a task and redirects" do
    assert_difference("Task.count", 1) do
      post tasks_path, params: { task: { title: "New task", description: "Details", due_date: "2026-04-01" } }
    end
    assert_redirected_to tasks_path
  end

  # Create - invalid
  test "POST /tasks with blank title renders unprocessable entity" do
    assert_no_difference("Task.count") do
      post tasks_path, params: { task: { title: "", description: "Details" } }
    end
    assert_response :unprocessable_entity
  end

  # Edit
  test "GET /tasks/:id/edit returns success" do
    get edit_task_path(@task)
    assert_response :success
  end

  # Update - valid
  test "PATCH /tasks/:id updates the task and redirects" do
    patch task_path(@task), params: { task: { title: "Updated title" } }
    assert_redirected_to task_path(@task)
    @task.reload
    assert_equal "Updated title", @task.title
  end

  # Update - invalid
  test "PATCH /tasks/:id with blank title renders unprocessable entity" do
    patch task_path(@task), params: { task: { title: "" } }
    assert_response :unprocessable_entity
  end

  # Destroy
  test "DELETE /tasks/:id destroys the task and redirects" do
    assert_difference("Task.count", -1) do
      delete task_path(@task)
    end
    assert_redirected_to tasks_path
  end
end
