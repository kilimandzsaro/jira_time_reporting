class ReportResult < ApplicationRecord
  has_many :employees
  has_many :issues
  has_many :reports
end
