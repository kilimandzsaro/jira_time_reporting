class SetIssuesDoneStatusByDefaultToFalse < ActiveRecord::Migration[5.0]
  def up
    change_column :issues, :is_done, :boolean, :default => false
  end

  def down
    change_column :issues, :is_done, :boolean, :default => nil
  end
end
