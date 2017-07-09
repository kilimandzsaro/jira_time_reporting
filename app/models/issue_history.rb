class IssueHistory < ApplicationRecord
  
  belongs_to :issue
  belongs_to :status

  validates_uniqueness_of :changelog_id_tag, scope: :issue_id

end
