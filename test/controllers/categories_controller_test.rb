require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create!(name: "Work")
  end

  test "GET /categories returns success" do
    get categories_path
    assert_response :success
  end

  test "GET /categories/new returns success" do
    get new_category_path
    assert_response :success
  end

  test "POST /categories creates a category" do
    assert_difference("Category.count", 1) do
      post categories_path, params: { category: { name: "Personal" } }
    end
    assert_redirected_to categories_path
  end

  test "POST /categories with blank name renders error" do
    assert_no_difference("Category.count") do
      post categories_path, params: { category: { name: "" } }
    end
    assert_response :unprocessable_entity
  end

  test "GET /categories/:id/edit returns success" do
    get edit_category_path(@category)
    assert_response :success
  end

  test "PATCH /categories/:id updates the category" do
    patch category_path(@category), params: { category: { name: "Updated" } }
    assert_redirected_to categories_path
    @category.reload
    assert_equal "Updated", @category.name
  end

  test "DELETE /categories/:id destroys the category" do
    assert_difference("Category.count", -1) do
      delete category_path(@category)
    end
    assert_redirected_to categories_path
  end
end
