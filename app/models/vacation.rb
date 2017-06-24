class Vacation < ApplicationRecord
  belongs_to :employee

  has_many :vacations_reports
  has_many :reports, through: :vacations_reports
end
