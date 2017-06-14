class AddStatusesReportTypesRelation < ActiveRecord::Migration[5.0]
  def change
    create_table :statuses_report_types do |t|
      t.references :status, index: true, foreign_key: true
      t.references :report_type, index: true, foreign_key: true
    end
  end
end
