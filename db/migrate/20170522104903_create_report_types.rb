class CreateReportTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :report_types do |t|
      t.string :report_type

      t.timestamps
    end
  end
end
