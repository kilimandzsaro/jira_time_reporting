class IssueHistory < ApplicationRecord
  
  belongs_to :issue
  belongs_to :status

end
