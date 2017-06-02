class Business < ApplicationRecord
  has_many :businesses_issues
  has_many :issues, through: :businesses_issues
  validates_uniqueness_of :name
end
