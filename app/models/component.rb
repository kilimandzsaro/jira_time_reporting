class Component < ApplicationRecord
  has_and_belongs_to_many :issue_histories
  validates_uniqueness_of :name
end
