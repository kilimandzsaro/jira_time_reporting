class Status < ApplicationRecord
  has_many :issue_histories
end
