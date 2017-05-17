class GetJiraResponseService
  
  require 'json'
  
  include HTTParty
  base_uri = "#{ENV['JIRA_URL']}/rest/api/2"

  def initialize(content_type, authorization)

  	@options = {
  	  headers: {
  		'Content-Type': content_type,
        'Authorization': authorization	
  	  }	
  	}

  end

  def all_issues(project)

  	total = get_total_results(project)
  	issues = Array.new(total)
  	startAt = 0
  	
    begin
      response = JSON.parse(self.class.get("/search?jql=project=#{project}&ORDER+BY+KEY+ASC&fields=id,key", @options))
      
      response["issues"].each do |issue|
      	issue_json = JSON.parse(issue)
      	issues << issue_json["key"]
      end
      
      startAt += 50
    end while total - startAt > 0

    p issues 
    
    return issues
  end

  def project_components(project)
  	
  	components = Array.new
  	response = self.class.get("/project/#{project}/components", @options)

  	response.each do |r|
  	  comp = JSON.parse(r)
  	  components << comp["name"]
  	end

    p components

    return components
  end

  private 

    def get_total_results(project)
      response = JSON.parse(self.class.get("/search?jql=project=#{project}&ORDER+BY+KEY+ASC&fields=id,key&maxResults=1", @options))  
    return response["total"].to_i

end