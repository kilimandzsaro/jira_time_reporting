class Componenet < ApplicationRecord
  has_and_belongs_to_many :issue_histories
end
