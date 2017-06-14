class ModifyDurationColumnsFromTimeToFloat < ActiveRecord::Migration[5.0]
  def change
    remove_column :issue_histories, :duration
    remove_column :report_results, :spent
    remove_column :report_results, :calculated

    add_column :issue_histories, :duration, :float
    add_column :report_results, :spent, :float
    add_column :report_results, :calculated, :float
  end
end
