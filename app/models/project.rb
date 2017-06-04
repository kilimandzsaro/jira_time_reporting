class Project < ApplicationRecord
  has_many :issues
  has_many :projects_report_types
  has_many :report_types, through: :projects_report_types
end
