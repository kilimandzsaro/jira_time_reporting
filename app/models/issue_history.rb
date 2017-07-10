class IssueHistory < ApplicationRecord
  
  belongs_to :issue
  belongs_to :status
  
  validates_uniqueness_of :changelog_id_tag, scope: :issue_id
  
  def get_days
    days = self.duration / 24
    return days.to_i
  end

  def get_hours
    hours = self.duration % 24
    return hours.to_i
  end

  def get_minutes
    minutes = 0.0
    # avoid devision by 0
    minutes = (self.duration % self.duration.to_i) * 60 if self.duration > 1
    return minutes.round
  end

end
