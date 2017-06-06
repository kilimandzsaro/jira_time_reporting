class AddCalculatedColumnToReportResultsTable < ActiveRecord::Migration[5.0]
  def up
    add_column :report_results, :calculated, :time
  end

  def down
    remove_column :report_results, :calculated
  end
end
