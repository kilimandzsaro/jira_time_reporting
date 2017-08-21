class CreateBusinesses < ActiveRecord::Migration[5.0]
  def change
    # drop_table :businesses
    
    create_table :businesses do |t|
      t.string :jira_name
      t.string :name
      t.decimal :price

      t.timestamps
    end
  end
end
