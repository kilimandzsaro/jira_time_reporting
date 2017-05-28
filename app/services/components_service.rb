class ComponentsService

  def initialize
  end
  
  def add_new_components(components)
    components.each do |c|
      add(c)
    end
  end

  private
  
  def add(comp)
    c = Component.new
    c.name = comp
    c.save
  end

end