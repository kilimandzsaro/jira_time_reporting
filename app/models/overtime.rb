class Overtime < ApplicationRecord
  belongs_to :employee

  has_many :overtimes_reports
  has_many :reports, through: :overtimes_reports
end
