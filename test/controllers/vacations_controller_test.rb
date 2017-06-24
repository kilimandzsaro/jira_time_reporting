require 'test_helper'

class VacationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vacation = vacations(:one)
    @vacation.employee_id = Employee.first.id
    @vacation.save!
  end

  test "should create vacation" do
    assert_difference('Vacation.count') do
      post vacations_url, params: { vacation: { employee_id: @vacation.employee_id, start_date: @vacation.start_date, end_date: @vacation.end_date } }
    end
  end

  test "should update vacation" do
    patch vacation_url(@vacation), params: { vacation: { employee_id: @vacation.employee_id, start_date: @vacation.start_date, end_date: @vacation.end_date - 1 } }
    assert_not_equal(@vacation.end_date, @vacation.reload.end_date)
  end

  test "should destroy vacation" do
    assert_difference('Vacation.count', -1) do
      delete vacation_url(@vacation)
    end
  end
end
