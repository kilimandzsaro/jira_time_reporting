class ModifyChangelogIdTagToUniqInIssueHistoriesTable < ActiveRecord::Migration[5.0]
  def change
    add_index_options :issue_histories, :changelog_id_tag, unique: true
  end
end
