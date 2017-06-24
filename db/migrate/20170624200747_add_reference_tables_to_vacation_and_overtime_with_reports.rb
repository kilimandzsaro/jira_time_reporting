class AddReferenceTablesToVacationAndOvertimeWithReports < ActiveRecord::Migration[5.0]
  def change
    create_table :vacations_reports do |t|
      t.references :vacation, index: true, foreign_key: true
      t.references :report, index: true, foreign_key: true
    end

    create_table :overtimes_reports do |t|
      t.references :overtime, index: true, foreign_key: true
      t.references :report, index: true, foreign_key: true
    end
  end
end
