class Issue < ApplicationRecord
  has_many :issue_histories
  has_many :components_issues
  has_many :components, through: :components_issues
  has_many :businesses_issues
  has_many :businesses, through: :businesses_issues
  has_many :projects

  validates_uniqueness_of :issue_key
  validates_uniqueness_of :jira_id_tag
end
