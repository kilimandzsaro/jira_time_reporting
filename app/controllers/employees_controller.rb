class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update]

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all
    @show_all = false
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    Employee.find(params[:id]).issue_history_id.each do |ihid| 
      employee_issues_id.push(IssueHistory.find(ihid).pluck(:issue_id))
    end
    employee_issues_id.each do |eiid|
      @employees_issues.push(Issue.find(eiid))
    end
  end

  # GET /employees/1/edit
  def edit
  end

  # PATCH/PUT /employees/1 change the status of the employee
  def hide_and_show
    @employee = Employee.find(params[:employee_id])

    @employee.hide = !@employee.hide

    respond_to do |format|
      if @employee.save
        format.html do
          redirect_to employees_path
        end
        format.json { render json: @employee.to_json}
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      @employee = Employee.find(params[:employee_id])
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /employees#refresh
  def refresh
    connect_to_jira = GetJiraResponseService.new
    Project.all.each do |project|
      employees = connect_to_jira.employees(project.prefix)
      employees.each do |employee|
        if Employee.find_by_email(employee['emailAddress']).nil?
          e = Employee.new(name: employee['name'], email: employee['emailAddress'], key: employee['key'], display_name: employee['displayName'], active: employee['active'])
          e.save!
        end
      end
    end
    redirect_to employees_path, notice: 'Employees was successfully updated'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:id, :name, :email, {issue_history: [:id]}, :hide)
    end
end
