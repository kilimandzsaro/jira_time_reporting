class FixIssueHistoryRelations < ActiveRecord::Migration[5.0]
  def change
    remove_column :issue_histories, :component_ids
    remove_column :issue_histories, :business_ids
  end
end
