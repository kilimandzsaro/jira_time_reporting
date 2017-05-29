class AddDoneDateToIssuesTable < ActiveRecord::Migration[5.0]
  def up
    add_column :issues, :done_date, :datetime
  end

  def down
    delete_column :issues, :done_date
  end
end
