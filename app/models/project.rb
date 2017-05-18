class Project < ApplicationRecord
  has_many :issue_histories
  has_many :issues, through :issue_histories
end
