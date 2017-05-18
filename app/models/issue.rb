class Issue < ApplicationRecord
  has_many :issue_histories
  has_many :employees, through :issue_histories
  has_many :business, through :issue_histories
  has_many :components, through :issue_histories
end
