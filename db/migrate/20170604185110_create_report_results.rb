class CreateReportResults < ActiveRecord::Migration[5.0]
  def change
    create_table :report_results do |t|
      t.references :employee, index: true, foreign_key: true
      t.time  :spent
      t.references :issue, index: true, foreign_key: true
      t.references :report, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
