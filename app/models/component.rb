class Component < ApplicationRecord
  has_many :components_issues
  has_many :issues, through: :components_issues
  validates_uniqueness_of :name
end
