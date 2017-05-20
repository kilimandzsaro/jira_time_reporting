class FixTypoInComponentsTable < ActiveRecord::Migration[5.0]
  def up
    rename_table :componenets, :components
  end

  def down
    rename_table :components, :componenets
  end
end
