class ProjectsReportType < ApplicationRecord
  belongs_to :project
  belongs_to :report_type
end