class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.string :name
      t.date :from_date
      t.date :to_date
      t.json :settings

      t.timestamps
    end
  end
end
