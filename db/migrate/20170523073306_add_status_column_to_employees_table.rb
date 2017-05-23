class AddStatusColumnToEmployeesTable < ActiveRecord::Migration[5.0]
  def up
    add_column :employees, :status, :string, default: 'active'
  end

  def down
    delete_column :employees, :status
  end
end
