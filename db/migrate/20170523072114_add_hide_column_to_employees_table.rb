class AddHideColumnToEmployeesTable < ActiveRecord::Migration[5.0]
  def up
    add_column :employees, :hide, :boolean, default: false
  end

  def down
    remove_column :employees, :hide
  end
end
