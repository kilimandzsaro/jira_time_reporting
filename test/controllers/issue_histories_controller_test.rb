require 'test_helper'

class IssueHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @issue_history = issue_histories(:one)
  end

  test "should get index" do
    get issue_histories_url
    assert_response :success
  end

  test "should show issue_history" do
    get issue_histories_url(@issue_history)
    assert_response :success
  end

end
