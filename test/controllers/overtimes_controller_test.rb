require 'test_helper'

class OvertimesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @overtime = overtimes(:one)
    @overtime.employee_id = Employee.first.id
    @overtime.save!
  end

  test "should create overtime" do
    assert_difference('Overtime.count') do
      post overtimes_url, params: { overtime: { employee_id: @overtime.employee_id, start_date: @overtime.start_date, end_date: @overtime.end_date } }
    end
  end

  test "should update overtime" do
    patch overtime_url(@overtime), params: { overtime: { employee_id: @overtime.employee_id, start_date: @overtime.start_date, end_date: @overtime.end_date - 1 } }
    assert_not_equal(@overtime.end_date, @overtime.reload.end_date)
  end

  test "should destroy overtime" do
    assert_difference('Overtime.count', -1) do
      delete overtime_url(@overtime)
    end
  end
end
