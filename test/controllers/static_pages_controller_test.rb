require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get employee" do
    get static_pages_employee_url
    assert_response :success
  end

  test "should get project" do
    get static_pages_project_url
    assert_response :success
  end

end
