class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :component
      t.string :business
      t.decimal :price

      t.timestamps
    end
  end
end