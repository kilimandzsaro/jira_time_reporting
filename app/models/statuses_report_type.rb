class StatusesReportType < ApplicationRecord
  belongs_to :status
  belongs_to :report_type
end