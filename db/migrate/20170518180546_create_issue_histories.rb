class CreateIssueHistories < ActiveRecord::Migration[5.0]
  def change
    # drop_table :issue_histories
    
    create_table :issue_histories do |t|
      t.integer :issue_id
      t.string :status
      t.datetime :start_date
      t.datetime :end_date
      t.integer :employee_id
      t.integer :components_id
      t.integer :business_id
      t.time :duration
      t.integer :project_id

      t.timestamps
    end
  end
end
