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
end
