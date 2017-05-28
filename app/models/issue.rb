class Issue < ApplicationRecord
  has_many :issue_histories
  validates_uniqueness_of :issue_key
  validates_uniqueness_of :jira_id
end
