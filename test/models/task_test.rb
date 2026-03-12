require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "task is valid with a title" do
    task = Task.new(title: "Test task")
    assert task.valid?
  end

  test "task is invalid without a title" do
    task = Task.new(title: nil)
    assert_not task.valid?
    assert_includes task.errors[:title], "can't be blank"
  end

  test "task is valid without a description" do
    task = Task.new(title: "Test task", description: nil)
    assert task.valid?
  end

  test "task is valid without a due date" do
    task = Task.new(title: "Test task", due_date: nil)
    assert task.valid?
  end

  test "completed defaults to false" do
    task = Task.create!(title: "Test task")
    assert_equal false, task.completed
  end

  test "toggle_completion! flips completed from false to true" do
    task = Task.create!(title: "Test task")
    assert_equal false, task.completed
    task.toggle_completion!
    assert_equal true, task.reload.completed
  end

  test "toggle_completion! flips completed from true to false" do
    task = Task.create!(title: "Test task", completed: true)
    assert_equal true, task.completed
    task.toggle_completion!
    assert_equal false, task.reload.completed
  end

  test "tasks are ordered by creation date newest first" do
    task_a = Task.create!(title: "Task A")
    task_b = Task.create!(title: "Task B")
    assert_equal [task_b, task_a], Task.newest_first.to_a
  end

  test "task is valid with priority high" do
    task = Task.new(title: "Test task", priority: "high")
    assert task.valid?
  end

  test "task is valid with priority medium" do
    task = Task.new(title: "Test task", priority: "medium")
    assert task.valid?
  end

  test "task is valid with priority low" do
    task = Task.new(title: "Test task", priority: "low")
    assert task.valid?
  end

  test "task is valid without priority" do
    task = Task.new(title: "Test task", priority: nil)
    assert task.valid?
  end

  test "task is invalid with unknown priority" do
    task = Task.new(title: "Test task", priority: "urgent")
    assert_not task.valid?
    assert_includes task.errors[:priority], "is not included in the list"
  end

  test "by_priority scope filters tasks" do
    high_task = Task.create!(title: "High task", priority: "high")
    low_task = Task.create!(title: "Low task", priority: "low")
    no_priority = Task.create!(title: "No priority task")

    assert_includes Task.by_priority("high"), high_task
    assert_not_includes Task.by_priority("high"), low_task
    assert_not_includes Task.by_priority("high"), no_priority
  end

  test "task can belong to a category" do
    category = Category.create!(name: "Work")
    task = Task.create!(title: "Work task", category: category)
    assert_equal category, task.category
  end

  test "task is valid without a category" do
    task = Task.new(title: "No category task", category: nil)
    assert task.valid?
  end

  test "by_category scope filters tasks" do
    work = Category.create!(name: "Work")
    personal = Category.create!(name: "Personal")
    work_task = Task.create!(title: "Work task", category: work)
    personal_task = Task.create!(title: "Personal task", category: personal)

    assert_includes Task.by_category(work.id), work_task
    assert_not_includes Task.by_category(work.id), personal_task
  end
end
