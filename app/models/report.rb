class Report < ApplicationRecord
  belongs_to :report_type

  has_many :vacations_reports
  has_many :vacations, through: :vacations_reports
  has_many :overtimes_reports
  has_many :overtimes, through: :overtimes_reports
end
