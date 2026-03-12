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

  # Toggle complete
  test "PATCH /tasks/:id/toggle_complete marks task as completed" do
    assert_equal false, @task.completed
    patch toggle_complete_task_path(@task)
    assert_redirected_to tasks_path
    @task.reload
    assert_equal true, @task.completed
  end

  test "PATCH /tasks/:id/toggle_complete marks completed task as incomplete" do
    @task.update!(completed: true)
    patch toggle_complete_task_path(@task)
    assert_redirected_to tasks_path
    @task.reload
    assert_equal false, @task.completed
  end

  # Preserve completion on edit
  test "PATCH /tasks/:id update preserves completed status" do
    @task.update!(completed: true)
    patch task_path(@task), params: { task: { title: "New title" } }
    @task.reload
    assert_equal true, @task.completed
    assert_equal "New title", @task.title
  end

  # Destroy
  test "DELETE /tasks/:id destroys the task and redirects" do
    assert_difference("Task.count", -1) do
      delete task_path(@task)
    end
    assert_redirected_to tasks_path
  end

  # Priority filtering
  test "GET /tasks with priority filter returns filtered tasks" do
    high_task = Task.create!(title: "High priority", priority: "high")
    low_task = Task.create!(title: "Low priority", priority: "low")

    get tasks_path, params: { priority: "high" }

    assert_response :success
    assert_match "High priority", response.body
    assert_no_match "Low priority", response.body
  end

  # Create with priority
  test "POST /tasks creates a task with priority" do
    post tasks_path, params: { task: { title: "Important task", priority: "high" } }
    assert_redirected_to tasks_path

    task = Task.last
    assert_equal "high", task.priority
  end

  # Create with category
  test "POST /tasks creates a task with category" do
    category = Category.create!(name: "Work")
    post tasks_path, params: { task: { title: "Work task", category_id: category.id } }
    assert_redirected_to tasks_path

    task = Task.last
    assert_equal category, task.category
  end

  # Category filtering
  test "GET /tasks with category filter returns filtered tasks" do
    work = Category.create!(name: "Work")
    personal = Category.create!(name: "Personal")
    work_task = Task.create!(title: "Work task", category: work)
    Task.create!(title: "Personal task", category: personal)

    get tasks_path, params: { category: work.id }

    assert_response :success
    assert_match "Work task", response.body
    assert_no_match "Personal task", response.body
  end
end
