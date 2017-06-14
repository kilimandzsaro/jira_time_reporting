class ModifyIssueHistoriesTableWithCorrectReferences < ActiveRecord::Migration[5.0]
  def change
    remove_column :issue_histories, :project_id
    remove_column :issue_histories, :issue_id
    remove_column :issue_histories, :employee_id
    remove_column :issue_histories, :status_id
    
    add_reference :issue_histories, :issue, index: true, foreign_key: true
    add_reference :issue_histories, :employee, index: true, foreign_key: true
    add_reference :issue_histories, :status, index: true, foreign_key: true
  end
end
