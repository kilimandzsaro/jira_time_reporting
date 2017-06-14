class AddComponentsIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :components_issues do |t|
      t.references :component, index: true, foreign_key: true
      t.references :issue, index: true, foreign_key: true
    end
  end
end
