class RemoveIssueHistoryIdColumnFromIssuesTable < ActiveRecord::Migration[5.0]
  def up
    remove_column :issues, :issue_history_id
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
