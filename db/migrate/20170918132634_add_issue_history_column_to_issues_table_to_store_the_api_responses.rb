class AddIssueHistoryColumnToIssuesTableToStoreTheApiResponses < ActiveRecord::Migration[5.0]
  def up
    add_column :issues, :issue_history, :json
  end

  def down
    remove_column :issues, :issue_history
  end
end
