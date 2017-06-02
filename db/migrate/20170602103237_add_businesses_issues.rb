class AddBusinessesIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :businesses_issues do |t|
      t.references :business, index: true, foreign_key: true
      t.references :issue, index: true, foreign_key: true
    end
  end
end
