class IssueHistory < ApplicationRecord
  
  belongs_to :issue
  belongs_to :status

  validates_uniqueness_of :changelog_id_tag, :employee_id, :status_id, scope: :issue_id

end
