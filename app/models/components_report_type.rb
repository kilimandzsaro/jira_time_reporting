class ComponentsReportType < ApplicationRecord
  belongs_to :component
  belongs_to :report_type
end