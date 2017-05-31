class IssueHistoriesService

  def initialize
  end

  def process_issue_history(history)
    issue_id = history['key']
    title = history['fields']['issuetype']['description']
    issue_type = history['fields']['issuetype']['name']
    component_ids = get_component_ids(history['fields']['components'])
    business_ids = get_add_business_ids(history['fields']['customfield_11301'])
    
    if (history['fields']['status']['name'] = 'Done' || history['fields']['status']['name'] = 'Closed')
      i = Issue.find_by(issue_key: issue_id)
      i.is_done = true
      i.done_date = history['fields']['updated']
    end

    @history = history['changelog']['histories']


  end

  private

  def get_component_ids(components)
    component_ids = Array.new
    components.each do |c|
      p "C: #{c}, NAME: #{c['name']}"
      component_ids << Component.find_by(name: c['name']).id
    end
    return component_ids
  end

  def get_add_business_ids(customfield_11301)
    business_ids = Array.new
    customfield_11301.each do |b|
      if  Business.find_by(jira_name: b) != nil
        business_ids << Business.find_by(jira_name: b).id
      else
        business = Business.new
        business.jira_name = b
        business.name = b
        business.price = 0
        business.save!
        business_ids << Business.find_by(jira_name: b).id
      end
    end
    return business_ids
  end

  def get_status_from_history(status)

  end

  def add_issue_history(issue_id, issue_type, status, start_date, end_date, employee_id, component_ids, business_ids)
    ih = IssueHistory.new
    ih.issue_id = issue_id
    ih.issue_type = issue_type
    ih.status = status
    ih.start_date = start_date
    ih.end_date = end_date
    ih.duration = end_date - start_date
    ih.employee_id = employee_id
    ih.component_id = component_ids
    ih.business_id = business_ids
    ih.save
  end
  
end