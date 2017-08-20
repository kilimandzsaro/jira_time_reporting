require 'test_helper'
require 'json'

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @e1 = employees(:one)
    @e2 = employees(:two)
  end

  test "should get index" do
    get employees_url
    assert_response :success
  end

  test "should show employee" do
    get employee_url(@e1)
    assert_response :success
  end

  test "should refresh the employees from Jira" do
    # not existing, so need to add
    response1 = [{
      name: "some.new",
      key: "somenew",
      emailAddress: "some.new@inbank.ee",
      displayName: "Some New",
      active: true
    }]
    # existing, so no need to add to the DB
    response2 = [{
      name: @e1.name,
      key: @e1.key,
      emailAddress: @e1.email,
      displayName: @e1.display_name,
      active: @e1.active
      }]

    mock = Minitest::Mock.new

    # I have 2 projects, so it should call 2 times. (Minitest magic)
    mock.expect :employees, response1, [String] # Mocking GetJiraResponseService.employees(project.prefix)
    mock.expect :employees, response2, [String] # Mocking GetJiraResponseService.employees(project.prefix)

    GetJiraResponseService.stub :new, mock do
      assert_difference('Employee.count') do
        get refresh_employees_url
        assert_redirected_to employees_url
      end
    end
    assert_mock mock
  end

  test "should update employee" do
    patch employee_url(@e2), params: { employee: { email: "new_email@new.now", name: @e2.name } }
    assert_not_equal(@e2.email, Employee.find_by_name(@e2.name).email)
    assert_redirected_to employee_url(@e2)
  end

  test "should change 'hide' state of the employee" do
    e = employees(:three)
    get employee_hide_and_show_url(e), params: { employee_id: e.id }
    assert_not_equal(e.hide, e.reload.hide)
    assert_redirected_to employees_url
  end

end
