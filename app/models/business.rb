class Business < ApplicationRecord
  has_many :businesses_issues
  has_many :issues, through: :businesses_issues
  has_many :businesses_report_types
  has_many :report_types, through: :businesses_report_types
  validates_uniqueness_of :name
end
