require 'test_helper'

class ShowResultsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @show_result = show_results(:one)
  end

  test "should get index" do
    get show_results_url
    assert_response :success
  end

  test "should get new" do
    get new_show_result_url
    assert_response :success
  end

  test "should create show_result" do
    assert_difference('ShowResult.count') do
      post show_results_url, params: { show_result: { name: 'New one', template: 'some template' } }
    end

    assert_redirected_to show_result_url(ShowResult.last)
  end

  test "should show show_result" do
    get show_result_url(@show_result)
    assert_response :success
  end

  test "should get edit" do
    get edit_show_result_url(@show_result)
    assert_response :success
  end

  test "should update show_result" do
    patch show_result_url(@show_result), params: { show_result: { template: 'new one' } }
    assert_not_equal(@show_result.template, @show_result.reload.template)
    assert_equal('new one', @show_result.reload.template)
    assert_redirected_to show_result_url(@show_result)
  end

  test "should destroy show_result" do
    assert_difference('ShowResult.count', -1) do
      delete show_result_url(@show_result)
    end

    assert_redirected_to show_results_url
  end
end
