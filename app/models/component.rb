class Component < ApplicationRecord
  has_many :components_issues
  has_many :issues, through: :components_issues
  has_many :components_report_types
  has_many :report_types, through: :components_report_types
  validates_uniqueness_of :name
end
