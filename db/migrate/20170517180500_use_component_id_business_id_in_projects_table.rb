class UseComponentIdBusinessIdInProjectsTable < ActiveRecord::Migration[5.0]
  def change
  	change_column :projects, :component, 'integer USING CAST(component AS integer)'
  	change_column :projects, :business, 'integer USING CAST(business AS integer)'
  end
end
