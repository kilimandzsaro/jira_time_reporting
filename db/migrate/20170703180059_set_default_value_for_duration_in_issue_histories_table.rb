class SetDefaultValueForDurationInIssueHistoriesTable < ActiveRecord::Migration[5.0]
  def change
    change_column :issue_histories, :duration, :float, :default => 0.0
  end
end
