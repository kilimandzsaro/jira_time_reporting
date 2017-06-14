class Status < ApplicationRecord
  has_many :issue_histories
  has_many :statuses_report_types
  has_many :report_types, through: :statuses_report_types
end
