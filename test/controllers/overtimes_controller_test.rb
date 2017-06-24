require 'test_helper'

class OvertimesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @overtime = overtimes(:one)
  end

  test "should create overtime" do
    assert_difference('Overtime.count') do
      post overtimes_url, params: { overtime: { employee_id: @overtime.employee_id, from_date: @overtime.from_date, to_date: @overtime.to_date } }
    end
  end

  test "should update overtime" do
    patch overtime_url(@overtime), params: { overtime: { employee_id: @overtime.employee_id, from_date: @overtime.from_date, to_date: @overtime.to_date - 1 } }
    assert_not_equal(@overtime.to_date, @overtime.reload.to_date)
  end

  test "should destroy overtime" do
    assert_difference('Overtime.count', -1) do
      delete overtime_url(@overtime)
    end
  end
end
