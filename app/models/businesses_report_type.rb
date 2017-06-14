class BusinessesReportType < ApplicationRecord
  belongs_to :business
  belongs_to :report_type
end