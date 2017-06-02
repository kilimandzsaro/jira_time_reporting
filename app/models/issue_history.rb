class IssueHistory < ApplicationRecord
  
  belongs_to :employee
  belongs_to :issue
  belongs_to :project
  belongs_to :status

end
