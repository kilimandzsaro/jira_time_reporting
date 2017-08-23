class GetJiraResponseService
  
  require 'json'
  
  include HTTParty
  base_uri = GlobalSetting.find_by(active: true).url.any? ? GlobalSetting.find_by(active: true).url : "https://jirareporting.inbank.ee"
  default_params :output => 'json'
  format :json

  attr_accessor :content_type, :authorization, :url

  def initialize
    self.content_type = "application/json"
    self.authorization = "Basic #{GlobalSetting.find_by(active: true).base64_key}"
    self.url = GlobalSetting.find_by(active: true).url
    set_header
  end

  def all_issues(project_id)
    project = Project.find(project_id).prefix
  	total = get_total_results(project)
  	issues = Array.new
  	startAt = 0
  	
    begin
      response = JSON.parse(self.class.get("#{url}/search?jql=project=#{project}&ORDER+BY+KEY+ASC&fields=id,key&startAt=#{startAt}", @options).to_s)
      
      response['issues'].each do |r|
        issues << {id: r['id'], key: r['key']} if r['id'] != nil
      end
      
      startAt += 50
    end while total - startAt > 0
    
    return issues
  end

  def project_components(project_id)
    project = Project.find(project_id).prefix
  	components = Array.new
  	response = JSON.parse(self.class.get("#{url}/project/#{project}/components", @options).to_s)
    response.each do |r|
      components << r['name']
    end

    return components
  end

  def issue_history(issue)
    response = JSON.parse(self.class.get("#{url}/issue/#{issue}?expand=changelog", @options).to_s)
    return response
  end

  def statuses
    response = JSON.parse(self.class.get("#{url}/status", @options).to_s)
    return response
  end

  def employees(project)
    response = JSON.parse(self.class.get("#{url}/user/assignable/search?project=#{project}", @options).to_s)
    return response
  end

  private 

  def get_total_results(project)
    response = JSON.parse(self.class.get("#{url}/search?jql=project=#{project}&ORDER+BY+KEY+ASC&fields=id,key&maxResults=1", @options).to_s)  
    return response['total'].to_i
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