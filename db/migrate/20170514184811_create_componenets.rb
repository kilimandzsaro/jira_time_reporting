class CreateComponenets < ActiveRecord::Migration[5.0]
  def change
    create_table :componenets do |t|
      t.string :name

      t.timestamps
    end
  end
end
