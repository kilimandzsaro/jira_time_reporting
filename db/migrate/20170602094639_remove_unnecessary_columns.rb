class RemoveUnnecessaryColumns < ActiveRecord::Migration[5.0]
  def up
    remove_column :employees, :issue_history_id
    remove_column :issue_histories, :status
    remove_column :issue_histories, :component_id
    remove_column :issue_histories, :business_id
    add_column :issue_histories, :status_id, :integer
    add_column :issue_histories, :component_ids, :integer, array: true, default: []
    add_column :issue_histories, :business_ids, :integer, array: true, default: []
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
