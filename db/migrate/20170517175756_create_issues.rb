class CreateIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :issues do |t|
      t.integer :jira_id
      t.string :issue_key
      t.string :title
      t.boolean :is_done

      t.timestamps
    end
  end
end
