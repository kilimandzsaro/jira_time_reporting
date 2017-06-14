class IssuesService

  def initialize
  end
  
  def add_new_issues(issues)
    issues.each do |i|
      id = i[:id].to_i
      key = i[:key]
      p "ISSUE ID: #{i[:id]}, ISSUE: #{i}, JSON: #{i.to_json}"
      add(id,key) if i['id'] != 0
    end
  end

  private
  def add(id,key)
    i = Issue.new
    i.jira_id_tag = id
    i.issue_key = key
    i.save
  end
  
end