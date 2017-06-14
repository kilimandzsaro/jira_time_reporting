class RenameIdEndingsInColumnsWhichIsNotAReference < ActiveRecord::Migration[5.0]
  def up
    rename_column :issues, :jira_id, :jira_id_tag
    rename_column :issue_histories, :history_id, :changelog_id_tag
  end

  def down
    rename_column :issues, :jira_id_tag, :jira_id
    rename_column :issue_histories, :changelog_id_tag, :history_id
  end
end
