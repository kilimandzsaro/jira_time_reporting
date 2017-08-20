class IssueHistory < ApplicationRecord
  
  belongs_to :issue
  belongs_to :status
  
  validates_uniqueness_of :changelog_id_tag, scope: :issue_id
  
  def get_days
    days = self.duration / 3600 / 24
    return days.to_i
  end

  def get_hours
    hours = (self.duration / 3600) % 24
    return hours.to_i
  end

  def get_minutes
    minutes = 0.0
    # Avoid devision by 0 (the if tag) 
    # Duration is in seconds
    minutes = ( (self.duration / 3600) % (self.duration / 3600).to_i) * 60 if self.duration > 3600
    return minutes.round
  end

end
