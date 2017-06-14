class AddCountedColumnToStatuses < ActiveRecord::Migration[5.0]
  def up
    add_column :statuses, :counted, :boolean, default: false
  end

  def down
    remove_column :statuses, :counted
  end
end
