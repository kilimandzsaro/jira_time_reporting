class EmployeesReportType < ApplicationRecord
  belongs_to :employee
  belongs_to :report_type
end