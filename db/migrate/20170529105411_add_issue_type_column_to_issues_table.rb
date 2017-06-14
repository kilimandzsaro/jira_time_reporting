class AddIssueTypeColumnToIssuesTable < ActiveRecord::Migration[5.0]
  def up
    add_column :issues, :issue_type, :string
  end

  def down
    remove_column :issues, :issue_type
  end
end
