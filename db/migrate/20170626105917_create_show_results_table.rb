class CreateShowResultsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :show_results do |t|
      t.string :name
      t.string :template

      t.timestamps
    end
  end
end
