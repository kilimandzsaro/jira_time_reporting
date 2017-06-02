class AddKeyColumnToEmployeesTable < ActiveRecord::Migration[5.0]
  def up
    add_column :employees, :key, :string
  end

  def down
    remove_column :employees, :key
  end
end
