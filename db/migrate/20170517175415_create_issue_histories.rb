class CreateIssueHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :issue_histories do |t|
      t.integer :issue_id
      t.string :status
      t.datetime :start_date
      t.datetime :end_date
      t.integer :user_id
      t.integer :components_id, array:true, default: []
      t.integer :business_id, array:true, default: []
      t.time :duration
      t.integer :project_id

      t.timestamps
    end
  end
end
