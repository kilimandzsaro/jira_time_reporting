class IssuesService

  def initialize
  end
  
  def add_new_issues(issues)
    issues.each do |i|
      id = i["id"]
      key = i["key"]
      add[id,key]
    end
  end

  private
  
  def add(comp)
    c = Component.new
    c.name = comp
    return unless c.save
  end

  private
  def add(id,key)
    i = Issue.new
    i.id = id
    i.key = key
    i.save
  end
  
end