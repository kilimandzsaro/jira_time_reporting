class CreateVacations < ActiveRecord::Migration[5.0]
  def change
    create_table :vacations do |t|
      t.date :start_date
      t.date :end_date
      t.references :employee, index: true, foreign_key: true

      t.timestamps
    end
  end
end
