class CreateResultViews < ActiveRecord::Migration[5.0]
  def change
    create_table :result_views do |t|
      t.string :name
      t.string :template

      t.timestamps
    end
  end
end
