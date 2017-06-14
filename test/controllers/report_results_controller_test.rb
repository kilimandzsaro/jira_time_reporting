require 'test_helper'

class ReportResultsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @report_result = report_results(:one)
  end

  test "should get index" do
    get report_results_url
    assert_response :success
  end

  test "should get new" do
    get new_report_result_url
    assert_response :success
  end

  test "should create report_result" do
    assert_difference('ReportResult.count') do
      post report_results_url, params: { report_result: {  } }
    end

    assert_redirected_to report_result_url(ReportResult.last)
  end

  test "should show report_result" do
    get report_result_url(@report_result)
    assert_response :success
  end

  test "should get edit" do
    get edit_report_result_url(@report_result)
    assert_response :success
  end

  test "should update report_result" do
    patch report_result_url(@report_result), params: { report_result: {  } }
    assert_redirected_to report_result_url(@report_result)
  end

  test "should destroy report_result" do
    assert_difference('ReportResult.count', -1) do
      delete report_result_url(@report_result)
    end

    assert_redirected_to report_results_url
  end
end
