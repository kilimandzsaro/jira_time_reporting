class IssueHistoriesService

  def initialize
  end

  def get_history_for_not_done_issues
    open_issues = Issue.where("is_done = false")
  end

  private
  def add_issue_history(issue_id, status, start_date, end_date, employee_id, component_id, business_id)
    ih = IssueHistory.new
    ih.issue_id = issue_id
    ih.status = status
    ih.start_date = start_date
    ih.end_date = end_date
    ih.duration = end_date - start_date
    ih.employee_id = employee_id
    ih.component_id = component_id
    ih.business_id = business_id
    ih.save
  end
  
end