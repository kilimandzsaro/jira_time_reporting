class EmployeesService
  def initialize
  end

  def add_inactive_employee_from_issue(name, display_name)
    e = Employee.new
    e.name = name
    e.key = name
    e.display_name = display_name
    e.active = false
    e.hide = true
    e.email = name
    e.save
  end
end