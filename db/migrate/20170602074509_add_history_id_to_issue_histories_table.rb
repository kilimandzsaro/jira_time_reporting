class AddHistoryIdToIssueHistoriesTable < ActiveRecord::Migration[5.0]
  def up
    add_column :issue_histories, :history_id, :integer
  end

  def down
    remove_column :issue_histories, :history_id
  end
end
