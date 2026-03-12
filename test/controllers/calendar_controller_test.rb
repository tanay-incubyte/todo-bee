require "test_helper"

class CalendarControllerTest < ActionDispatch::IntegrationTest
  test "GET /calendar returns success" do
    get calendar_path
    assert_response :success
  end

  test "GET /calendar with month view" do
    get calendar_path, params: { view: "month" }
    assert_response :success
  end

  test "GET /calendar with week view" do
    get calendar_path, params: { view: "week" }
    assert_response :success
  end

  test "GET /calendar with day view" do
    get calendar_path, params: { view: "day" }
    assert_response :success
  end

  test "GET /calendar with specific date" do
    get calendar_path, params: { date: "2026-04-15" }
    assert_response :success
  end
end
