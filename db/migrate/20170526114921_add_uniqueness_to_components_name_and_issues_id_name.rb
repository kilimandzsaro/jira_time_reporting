class AddUniquenessToComponentsNameAndIssuesIdName < ActiveRecord::Migration[5.0]
  def up
    add_index :components, [:name], unique: true
    add_index :issues, [:jira_id, :issue_key], unique:true
  end

  def down
    remove_index :components, [:name]
    remove_index :issues, [:jira_id, :issue_key]
  end
end
