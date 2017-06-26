require 'test_helper'

class ResultViewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @result_view = result_views(:one)
  end

  test "should get index" do
    get result_views_url
    assert_response :success
  end

  test "should get new" do
    get new_result_view_url
    assert_response :success
  end

  test "should create result_view" do
    assert_difference('ResultView.count') do
      post result_views_url, params: { result_view: { name: 'New one', template: 'some template' } }
    end

    assert_redirected_to result_view_url(ResultView.last)
  end

  test "should show result_view" do
    get result_view_url(@result_view)
    assert_response :success
  end

  test "should get edit" do
    get edit_result_view_url(@result_view)
    assert_response :success
  end

  test "should update result_view" do
    patch result_view_url(@result_view), params: { result_view: { template: 'new one' } }
    assert_not_equal(@result_view.template, @result_view.reload.template)
    assert_equal('new one', @result_view.reload.template)
    assert_redirected_to result_view_url(@result_view)
  end

  test "should destroy result_view" do
    assert_difference('ResultView.count', -1) do
      delete result_view_url(@result_view)
    end

    assert_redirected_to result_views_url
  end
end
