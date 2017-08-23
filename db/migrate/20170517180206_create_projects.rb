class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    # drop_table :projects
    
    create_table :projects do |t|
      t.string :prefix
      t.string :name

      t.timestamps
    end
  end
end
