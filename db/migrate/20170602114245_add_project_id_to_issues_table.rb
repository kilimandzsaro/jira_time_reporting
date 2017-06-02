class AddProjectIdToIssuesTable < ActiveRecord::Migration[5.0]
  def change
    add_reference :issues, :project, index: true, foreign_key: true
  end
end
