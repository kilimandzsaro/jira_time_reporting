class ComponentsIssue < ApplicationRecord
  belongs_to :component
  belongs_to :issue
end