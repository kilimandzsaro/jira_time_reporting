require 'test_helper'

class VacationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vacation = vacations(:one)
  end

  test "should create vacation" do
    assert_difference('Vacation.count') do
      post vacations_url, params: { vacation: { employee_id: @vacation.employee_id, from_date: @vacation.from_date, to_date: @vacation.to_date } }
    end
  end

  test "should update vacation" do
    patch vacation_url(@vacation), params: { vacation: { employee_id: @vacation.employee_id, from_date: @vacation.from_date, to_date: @vacation.to_date - 1 } }
    assert_not_equal(@vacation.to_date, @vacation.reload.to_date)
  end

  test "should destroy vacation" do
    assert_difference('Vacation.count', -1) do
      delete vacation_url(@vacation)
    end
  end
end
