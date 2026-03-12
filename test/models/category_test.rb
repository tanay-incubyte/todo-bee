require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "category is valid with a name" do
    category = Category.new(name: "Work")
    assert category.valid?
  end

  test "category is invalid without a name" do
    category = Category.new(name: nil)
    assert_not category.valid?
    assert_includes category.errors[:name], "can't be blank"
  end

  test "category is invalid with blank name" do
    category = Category.new(name: "")
    assert_not category.valid?
  end

  test "deleting category sets task category to nil" do
    category = Category.create!(name: "Work")
    task = Task.create!(title: "Work task", category: category)

    category.destroy

    task.reload
    assert_nil task.category_id
  end
end
