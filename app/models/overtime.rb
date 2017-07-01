class Overtime < ApplicationRecord
  belongs_to :employee

  has_many :overtimes_reports
  has_many :reports, through: :overtimes_reports

  validates_uniqueness_of :employee_id, scope: :report_id
end
