class BusinessesIssue < ApplicationRecord
  belongs_to :business
  belongs_to :issue
end