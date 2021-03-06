class IssueHistoriesService

  attr_accessor :history, :issue

  def initialize(history)
    self.history = history
  end

  def process_issue_history
    self.issue = Issue.find_by(issue_key: history['key'])
    issue.title = history['fields']['summary']
    issue.issue_type = history['fields']['issuetype']['name']
    add_components_to_components_issues_table(history['fields']['components'])
    add_businesses_to_businesses_issues_table(history['fields']['customfield_11301']) unless history['fields']['customfield_11301'].nil?
    add_project_id_to_issue(Project.find_by_prefix(history['fields']['project']['key']).id)
    
    # some cases when the card was assigned to a person and he moved the card, in the history there is the status change, but no assignee change. 
    # And it is not stored in the history
    @original_assignee = 0
    if !history['fields']['assignee'].nil? && Employee.where("key like ?","#{history['fields']['assignee']['key']}%").empty? 
      emp = EmployeesService.new
      emp.add_inactive_employee_from_issue(history['fields']['assignee']['key'], history['fields']['assignee']['name'])
    end
    @original_assignee = Employee.where("key like ?","#{history['fields']['assignee']['key']}%").first.id if !history['fields']['assignee'].nil?
    
    process_history(history['changelog']['histories'])

    issue.save
  end

  def calculate_duration
    duration = 0
    
    if history.end_date.nil?
      return
    elsif history.end_date - history.start_date < (4 * 60 * 60) # if the difference is less than 4 hours
      duration = history.end_date - history.start_date
    else
      duration = history.start_date.business_time_until(history.end_date)
    end

    if history.duration != duration
      history.duration = duration
      history.save!
    end
  end

  private

  def process_history(history)
    assignee_id = @original_assignee
    history.sort_by {|e| e[:id]}
    history.each do |h|
      changelog_history_id = h['id']
      h['items'].each do |item|
        assignee_id = get_assignee_id_from_history_item(item, assignee_id)
        new_status_id = get_next_status_id(item)
        ih = add_issue_history(changelog_history_id, issue.id, new_status_id, h['created'], assignee_id) 
        add_done_issue_history(ih) if update_issue_done_state(h['created'], new_status_id)
      end
    end
  end

  def get_assignee_id_from_history_item(item, original_assignee)
    if item['field'] == 'assignee'
      if Employee.where("key like ?","#{item['to']}%").empty?
        emp = EmployeesService.new
        emp.add_inactive_employee_from_issue(item['to'], item['toString'])
      end
      return Employee.where("key like ?","#{item['to']}%").first.id
    end
    return original_assignee
  end

  def get_next_status_id(item)
    if Status.find_by_name(item['toString']).nil? && item['field'] == 'status'
      s = Status.new
      s.name = item['toString']
      s.save
    end
    
    return Status.find_by_name(item['toString']).id if item['field'] == 'status'
  end

  def update_issue_done_state(start_at, new_status_id)
    if !new_status_id.nil? && (Status.find(new_status_id).name == 'Done' || Status.find(new_status_id).name == 'Closed')
      ih = IssueHistory.order("changelog_id_tag DESC").find_by(issue_id: issue.id)
      if !ih.nil? && !issue.is_done
        ih.end_date = start_at unless ih.end_date == start_at
        ih.save
        return true
      end
    # need to handle the non status change changelogs. In these cases the status_id is empty and no need to save the issue history
    elsif new_status_id.nil?
      return true
    end
    return false
  end

  def add_components_to_components_issues_table(components)
    components.each do |c|
      if ComponentsIssue.find_by(component_id: Component.find_by_name(c['name']).id, issue_id: issue.id).nil?
        ci = ComponentsIssue.new
        ci.component_id = Component.find_by_name(c['name']).id
        ci.issue_id = issue.id
        ci.save
      end
    end
  end

  def add_businesses_to_businesses_issues_table(businesses)
    businesses.each do |b|
      # For custom fields there is no other chance to get the variations, so we have to add a new ones on the fly
      if Business.find_by_jira_name(b).nil?
        new_business = Business.new
        new_business.jira_name = b
        new_business.name = b
        new_business.price = 0
        new_business.save
      end

      if BusinessesIssue.find_by(business_id: Business.find_by_jira_name(b).id, issue_id: issue.id).nil?
        bi = BusinessesIssue.new
        bi.business_id = Business.find_by_jira_name(b).id
        bi.issue_id = issue.id
        bi.save
      end
    end
    
  end

  def add_project_id_to_issue(project_id)
    issue.project_id = project_id unless issue.project_id == project_id
  end

  def add_issue_history(history_id, issue_id, status_id, start_date, employee_id)
    ih = IssueHistory.new
    ih.changelog_id_tag = history_id
    ih.issue_id = issue_id
    ih.status_id = status_id
    ih.start_date = start_date
    ih.employee_id = employee_id unless employee_id == 0
    ih.save
    # return the object in case some other method wants to do something else with it
    return ih
  end

  def add_done_issue_history(issue_history)
    issue_history.end_date = issue_history.start_date
    issue_history.duration = 0
    Issue.find(issue_history.issue_id).update(is_done: true)
    issue_history.save
  end
  
end
