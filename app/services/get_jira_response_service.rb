class GetJiraResponseService
  
  require 'json'
  
  include HTTParty
  base_uri = "inbank.atlassian.net/rest/api/2" # "#{ENV['JIRA_URL']}/rest/api/2"
  default_params :output => 'json'
  format :json

  attr_accessor :content_type, :authorization, :url

  def initialize(content_type, authorization)
    self.content_type = content_type
    self.authorization = authorization
    self.url = "https://inbank.atlassian.net/rest/api/2"
    set_header
  end

  def all_issues(project)

  	total = get_total_results(project)
  	issues = Array.new
  	startAt = 0
  	
    begin
      response = JSON.parse(self.class.get("#{url}/search?jql=project=#{project}&ORDER+BY+KEY+ASC&fields=id,key&startAt=#{startAt}", @options).to_s)
      
      response["issues"].each do |r|
        issues << {id: r['id'], key: r['key']} if r['id'] != nil
      end
      
      startAt += 50
    end while total - startAt > 0
    
    return issues
  end

  def project_components(project)
  	
  	components = Array.new
  	response = JSON.parse(self.class.get("#{url}/project/#{project}/components", @options).to_s)
    response.each do |r|
      components << r["name"]
    end

    return components
  end

  private 

    def get_total_results(project)
      response = JSON.parse(self.class.get("#{url}/search?jql=project=#{project}&ORDER+BY+KEY+ASC&fields=id,key&maxResults=1", @options).to_s)  
      return response["total"].to_i
    end

    def set_header
      @options = {
        headers: {
          'Content-Type': content_type,
          'Authorization': authorization  
        } 
      }
    end

end