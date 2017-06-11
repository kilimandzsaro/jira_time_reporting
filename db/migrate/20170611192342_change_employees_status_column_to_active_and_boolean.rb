class ChangeEmployeesStatusColumnToActiveAndBoolean < ActiveRecord::Migration[5.0]
  def up
    remove_column :employees, :status
    add_column :employees, :active, :boolean, default: true
  end

  def down
    remove_column :employees, :active
    add_column :employees, :status, :boolean, default: true
  end
end
