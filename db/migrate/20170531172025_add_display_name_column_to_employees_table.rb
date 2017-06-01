class AddDisplayNameColumnToEmployeesTable < ActiveRecord::Migration[5.0]
  def up
    add_column :employees, :display_name, :string
  end

  def down
    delete_column :employees, :display_name
  end
end
