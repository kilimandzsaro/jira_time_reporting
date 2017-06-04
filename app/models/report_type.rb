class ReportType < ApplicationRecord
  has_many :employees_report_types
  has_many :employees, through: :employees_report_types
  has_many :components_report_types
  has_many :components, through: :components_report_types
  has_many :businesses_report_types
  has_many :businesses, through: :businesses_report_types
  has_many :projects_report_types
  has_many :projects, through: :projects_report_types
  has_many :statuses_report_types
  has_many :statuses, through: :statuses_report_types
  has_many :reports
end
