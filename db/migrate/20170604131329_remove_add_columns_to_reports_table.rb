class RemoveAddColumnsToReportsTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :reports, :settings
    
    add_reference :reports, :report_type, index: true, foreign_key: true
  end
end
