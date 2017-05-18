class IssueHistory < ApplicationRecord
  
  belongs_to :employees

  has_one :issues
  has_one :projects

  has_and_belongs_to_many :components
  has_and_belongs_to_many :business

end
