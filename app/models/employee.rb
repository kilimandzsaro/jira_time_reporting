class Employee < ApplicationRecord
  has_many :issue_histories

  has_many :employees_report_types
  has_many :report_types, through: :employees_report_types

end
