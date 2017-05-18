class AddingIndexingToTables < ActiveRecord::Migration[5.0]
  def change

    change_table :employees do |t|
      t.belongs_to :issue_history, index: true
    end

    change_table :issues do |t|
      t.belongs_to :issue_history, index: true
    end

    change_table :issue_histories do |t|
      t.rename :components_id, :component_id
    end

    change_column :issue_histories, :component_id, 'integer USING CAST(component_id AS integer)'
    change_column :issue_histories, :business_id, 'integer USING CAST(business_id AS integer)'

  end
end
